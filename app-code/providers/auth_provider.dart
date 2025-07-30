// File: lib/providers/auth_provider.dart

import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _loggedInUser;

  // Returns the currently logged-in username, or null if none
  String? get loggedInUser => _loggedInUser;

  // Indicates whether a user is currently logged in
  bool get isLoggedIn => _loggedInUser != null;

  // Sets the logged-in user and notifies listeners
  void login(String username) {
    _loggedInUser = username;
    notifyListeners();
  }

  // Logs out the current user and notifies listeners
  void logout() {
    _loggedInUser = null;
    notifyListeners();
  }
}
