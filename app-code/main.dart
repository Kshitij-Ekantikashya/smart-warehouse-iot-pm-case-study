// lib/main.dart
// Updated to easily switch between live and mock data modes.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/reading_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/connectivity_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'services/api_service.dart';
import 'services/mock_api_service.dart'; // Import the mock service
import 'theme/colors.dart';

void main() {
  // --- DEMO MODE CONTROL ---
  // Set to `true` to use simulated data for demos.
  // Set to `false` to connect to the real hardware.
  const bool useMockData = true;

  runApp(SmartWarehouseApp(useMockData: useMockData));
}

class SmartWarehouseApp extends StatelessWidget {
  final bool useMockData;

  const SmartWarehouseApp({super.key, required this.useMockData});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Conditionally provide either the real or mock ApiService
        ChangeNotifierProvider(
          create: (_) => ReadingProvider(
            apiService: useMockData ? MockApiService() : ApiService(),
          )..startPolling(),
        ),
        ChangeNotifierProvider(create: (_) => SettingsProvider()..loadSettings()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
      ],
      child: MaterialApp(
        title: 'Smart Warehouse',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: const ColorScheme.dark(
            primary: AppColors.primary,
            secondary: AppColors.accent,
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: AppColors.text),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/dashboard': (context) => const DashboardScreen(),
        },
      ),
    );
  }
}
