// File: lib/services/mock_api_service.dart
// Generates simulated data for demonstrating the app without live hardware.

import 'dart:async';
import 'dart:math';
import 'api_service.dart';
import '../models/reading.dart';
import '../models/rfid_log.dart';

class MockApiService extends ApiService {
  final Random _random = Random();

  // Simulate fetching the latest sensor reading
  @override
  Future<Reading> fetchLatestReading() async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // Generate realistic random values
    return Reading(
      temperature: 25.0 + (_random.nextDouble() * 15), // Realistic range: 25-40°C
      humidity: 40.0 + (_random.nextDouble() * 30),    // Realistic range: 40-70%
      gas: 150.0 + (_random.nextDouble() * 200),       // Realistic range: 150-350 ppm
      space: 60.0 + (_random.nextDouble() * 35),       // Space used: 60-95%
      stack: 30.0 + (_random.nextDouble() * 60),       // Stack height: 30-90%
      distSpace: 5.0 + (_random.nextDouble() * 20),    // Distance for space: 5-25 cm
      distStack: 2.0 + (_random.nextDouble() * 16),    // Distance for stack: 2-18 cm
      timestamp: DateTime.now(),
      // 10% chance of triggering an alarm in any given reading
      alarm: _random.nextDouble() < 0.1,
    );
  }

  // Simulate fetching recent RFID logs
  @override
  Future<List<RfidLog>> fetchRecentRfidLogs({int limit = 10}) async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 200));

    const items = ['Component Box A', 'Tool Kit B', 'Raw Material C', 'Finished Good D'];
    const directions = ['in', 'out'];

    // Generate a list of mock RFID logs
    return List.generate(limit, (index) {
      return RfidLog(
        // Format timestamp to be readable
        timestamp: _formatDateTime(DateTime.now().subtract(Duration(minutes: index * 5))),
        uid: 'UID${1000 + _random.nextInt(9000)}',
        item: items[_random.nextInt(items.length)],
        direction: directions[_random.nextInt(directions.length)],
      );
    });
  }

  // Helper to format DateTime to a clean string like '14:35:10'
  String _formatDateTime(DateTime dt) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(dt.hour)}:${twoDigits(dt.minute)}:${twoDigits(dt.second)}";
  }

  // Mock other API calls to prevent errors, returning default success values
  @override
  Future<bool> login(String username, String password) async => true;

  @override
  Future<bool> requestBuzzer() async => true;
}
