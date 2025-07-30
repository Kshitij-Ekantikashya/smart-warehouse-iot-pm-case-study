// File: lib/providers/reading_provider.dart
// Updated to support both real and mock API services.

import 'dart:async';
import 'package:flutter/material.dart';
import '../models/reading.dart';
import '../models/rfid_log.dart';
import '../services/api_service.dart';

class ReadingProvider extends ChangeNotifier {
  final ApiService _api; // Now accepts an ApiService instance
  Reading _latestReading = Reading.empty();
  final List<Reading> _recentReadings = [];
  List<RfidLog> _recentRfidLogs = [];
  Timer? _pollingTimer;
  DateTime? _lastAlarmTs;

  // Constructor to allow injecting the desired ApiService (real or mock)
  ReadingProvider({ApiService? apiService}) : _api = apiService ?? ApiService();

  Reading get latestReading => _latestReading;
  List<Reading> get recentReadings => _recentReadings;
  List<RfidLog> get recentRfidLogs => _recentRfidLogs;
  DateTime? get lastAlarmTs => _lastAlarmTs;

  final Map<String, double> _thresholds = {
    'temperature': 40.0,
    'humidity': 90.0,
    'gas': 500.0,
  };
  Map<String, double> get thresholds => _thresholds;

  void startPolling() {
    _pollingTimer?.cancel();
    _fetchAndNotify(); // Fetch immediately on start
    _pollingTimer = Timer.periodic(const Duration(seconds: 2), (_) => _fetchAndNotify());
  }

  Future<void> _fetchAndNotify() async {
    try {
      // Use the injected API service to fetch data
      final reading = await _api.fetchLatestReading();
      final rfidLogs = await _api.fetchRecentRfidLogs();

      _latestReading = reading;
      _recentRfidLogs = rfidLogs;
      _updateRecentReadings(reading);

      if (reading.alarm && (_lastAlarmTs == null || _lastAlarmTs != reading.timestamp)) {
        _lastAlarmTs = reading.timestamp;
      }
    } catch (e) {
      print("Error fetching data: $e");
      // You could add logic here to show an error state in the UI
    } finally {
      notifyListeners(); // Update the UI with new data or after an error
    }
  }

  void _updateRecentReadings(Reading reading) {
    _recentReadings.insert(0, reading);
    if (_recentReadings.length > 120) { // Keep only the last 2 minutes of data
      _recentReadings.removeLast();
    }
  }

  void stopPolling() {
    _pollingTimer?.cancel();
  }

  @override
  void dispose() {
    stopPolling();
    super.dispose();
  }
}
