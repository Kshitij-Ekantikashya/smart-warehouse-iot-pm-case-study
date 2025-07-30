// File: lib/providers/reading_provider.dart

import 'dart:async';
import 'package:flutter/material.dart';
import '../models/reading.dart';
import '../models/rfid_log.dart';
import '../services/api_service.dart';

class ReadingProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  Reading _latestReading = Reading.empty();
  Reading get latestReading => _latestReading;

  final List<Reading> _recentReadings = [];
  List<Reading> get recentReadings => _recentReadings;

  List<Reading> _recentEnvLogs = [];
  List<Reading> get recentEnvLogs => _recentEnvLogs;

  List<RfidLog> _recentRfidLogs = [];
  List<RfidLog> get recentRfidLogs => _recentRfidLogs;

  Map<String, double> _thresholds = {
    'temperature': 40.0,
    'humidity': 90.0,
    'gas': 500.0,
  };
  Map<String, double> get thresholds => _thresholds;

  Timer? _pollingTimer;
  DateTime _lastUpdated = DateTime.fromMillisecondsSinceEpoch(0);

  DateTime? _lastAlarmTs;
  DateTime? get lastAlarmTs => _lastAlarmTs;

  // Starts periodic polling every 2 seconds
  void startPolling() {
    _pollingTimer?.cancel();
    _fetchAndNotify();
    pollingTimer = Timer.periodic(const Duration(seconds: 2), () {
      _fetchAndNotify();
    });
  }

  // Fetches latest reading and updates state
  Future<void> _fetchAndNotify() async {
    try {
      final reading = await _api.fetchLatestReading();
      _latestReading = reading;
      _updateRecentReadings(reading);
      _lastUpdated = DateTime.now();

      if (reading.alarm == true) {
        if (_lastAlarmTs == null ||
            _lastAlarmTs!.toIso8601String() != reading.timestamp.toIso8601String()) {
          _lastAlarmTs = reading.timestamp;
          notifyListeners(); // Trigger UI for alarm
        }
      }

      _recentEnvLogs = await _api.fetchRecentEnvLogs();
      final rfidLogs = await _api.fetchRecentRfidLogs();
      updateRecentRfidLogs(rfidLogs);

      print('latestReading: $_latestReading');
      print('Env logs: ${_recentEnvLogs.length}, RFID logs: ${_recentRfidLogs.length}');
    } catch (e) {
      print('Error in _fetchAndNotify: $e');
    } finally {
      notifyListeners(); // Always update UI
    }
  }

  // Updates RFID logs and notifies listeners
  void updateRecentRfidLogs(List<RfidLog> logs) {
    _recentRfidLogs = logs;
    notifyListeners();
  }

  // Inserts new reading and maintains recent list
  void _updateRecentReadings(Reading reading) {
    _recentReadings.insert(0, reading);
    if (_recentReadings.length > 120) {
      _recentReadings.removeLast();
    }
  }

  // Stops polling when not needed
  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  // Updates a specific threshold
  void setThreshold(String key, double value) {
    _thresholds[key] = value;
    notifyListeners();
  }

  // Loads thresholds from storage or backend
  void loadThresholds(Map<String, double> newThresholds) {
    _thresholds = newThresholds;
    notifyListeners();
  }

  // Checks if NodeMCU data is recent
  bool get isNodeMcuConnected {
    final diff = DateTime.now().difference(_latestReading.timestamp);
    return diff.inSeconds < 5;
  }

  // Checks if app is actively receiving data
  bool get isConnected {
    final diff = DateTime.now().difference(_lastUpdated);
    return diff.inSeconds < 5;
  }

  @override
  void dispose() {
    stopPolling();
    super.dispose();
  }
}
