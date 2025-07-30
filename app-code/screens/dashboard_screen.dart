// File: lib/screens/dashboard_screen.dart
// Smart Warehouse – Dashboard UI with Realtime Monitoring, Alerts, and Logout

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/reading_provider.dart';
import '../widgets/kpi_tile.dart';
import '../widgets/system_status_tiles.dart';
import '../widgets/stack_space_donut.dart';
import '../widgets/trend_line_chart.dart';
import '../widgets/rfid_log_table.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime? _shownAlarmTs;

  @override
  void initState() {
    super.initState();
    context.read<ReadingProvider>().startPolling();
  }

  // Clears stored session and returns to login
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final reading = context.watch<ReadingProvider>().latestReading;
    final thresholds = context.watch<ReadingProvider>().thresholds;

    final tempAlert = reading.temperature > (thresholds['temperature'] ?? double.infinity);
    final humidityAlert = reading.humidity > (thresholds['humidity'] ?? double.infinity);
    final gasAlert = reading.gas > (thresholds['gas'] ?? double.infinity);

    // Show alert dialog once for a new alarm timestamp
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final latest = context.read<ReadingProvider>().latestReading;
      final lastAlarm = context.watch<ReadingProvider>().lastAlarmTs;

      if (latest.alarm && lastAlarm != null) {
        if (_shownAlarmTs == null || _shownAlarmTs!.toIso8601String() != lastAlarm.toIso8601String()) {
          _shownAlarmTs = lastAlarm;

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.red.shade900,
              title: const Text(
                "Warehouse Alarm",
                style: TextStyle(color: Colors.white),
              ),
              content: const Text(
                "A critical condition has been detected.\n\nPlease check gas, fire, or temperature readings.",
                style: TextStyle(color: Colors.white70),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Dismiss", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Warehouse Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Environment KPIs
            Row(
              children: [
                Expanded(
                  child: KpiTile(
                    label: "Temperature",
                    value: "${reading.temperature.toStringAsFixed(1)}°C",
                    icon: Icons.thermostat,
                    alert: tempAlert,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: KpiTile(
                    label: "Humidity",
                    value: "${reading.humidity.toStringAsFixed(1)}%",
                    icon: Icons.water_drop,
                    alert: humidityAlert,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: KpiTile(
                    label: "Gas",
                    value: "${reading.gas.toStringAsFixed(1)} ppm",
                    icon: Icons.cloud,
                    alert: gasAlert,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // System Info (e.g., WiFi, Clock, NodeMCU status)
            const SystemStatusTiles(),

            const SizedBox(height: 24),

            // Stack usage and trend line chart
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: StackSpaceDonut(reading: reading),
                ),
                const SizedBox(width: 24),
                const Expanded(
                  flex: 6,
                  child: TrendLineChart(),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Recent RFID log entries
            const RfidLogTable(),

            const SizedBox(height: 24),

            // Placeholder for remaining components
            SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  "Remaining Phase 2 widgets (buzzer, whitelist, etc.) will appear here.",
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
