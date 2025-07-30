import 'dart:async';
import 'dart:math';

import 'reading.dart';
import 'rfid_log.dart';

class MockApiService {
  final Random _random = Random();
  Timer? _pollingTimer;

  // Simulate dynamic environmental readings
  Future<Reading> fetchLatestReading() async {
    await Future.delayed(Duration(milliseconds: 500)); // simulate network delay

    return Reading(
      temperature: 20 + _random.nextDouble() * 15, // 20-35°C
      humidity: 40 + _random.nextDouble() * 30, // 40-70%
      gas: 100 + _random.nextDouble() * 200, // 100-300 ppm
      space: 60 + _random.nextDouble() * 30, // 60-90%
      stack: 30 + _random.nextDouble() * 40, // 30-70%
      distSpace: 5 + _random.nextDouble() * 15, // 5-20cm
      distStack: 8 + _random.nextDouble() * 10, // 8-18cm
      timestamp: DateTime.now(),
      alarm: _random.nextDouble() < 0.1, // 10% chance alarm
    );
  }

  // Simulate recent RFID logs
  Future<List<RfidLog>> fetchRecentRfidLogs({int limit = 10}) async {
    await Future.delayed(Duration(milliseconds: 300));
    final items = ['Widget A', 'Component B', 'Part C', 'Tool D'];
    final directions = ['in', 'out'];

    return List.generate(limit, (index) {
      return RfidLog(
        timestamp: DateTime.now()
            .subtract(Duration(minutes: index * 5))
            .toString(),
        uid: 'UID${1000 + _random.nextInt(9000)}',
        item: items[_random.nextInt(items.length)],
        direction: directions[_random.nextInt(directions.length)],
      );
    });
  }

  // Optional: Stream to simulate real-time updates (if needed)
  Stream<Reading> getRealtimeReadings(Duration interval) async* {
    while (true) {
      await Future.delayed(interval);
      yield await fetchLatestReading();
    }
  }

  // If your provider can handle streams, you can add more simulation here.

  // Dispose to cancel timers if used
  void dispose() {
    _pollingTimer?.cancel();
  }
}
