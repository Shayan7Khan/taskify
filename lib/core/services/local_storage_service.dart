import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final String keyAccessToken = 'access_token';
  final String keyRefreshToken = 'refresh_token';
  final String keyUserId = 'user_id';

  //function to save session token
  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required String userId,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(keyAccessToken, accessToken);
    await prefs.setString(keyRefreshToken, refreshToken);
    await prefs.setString(keyUserId, userId);
    if (kDebugMode) {
      print('Session saved successfully. ');
    }
  }

  //function to get session token
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyAccessToken);
  }

  // Get user ID
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUserId);
  }

  //clear session
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyAccessToken);
    await prefs.remove(keyRefreshToken);
    await prefs.remove(keyUserId);
    if (kDebugMode) {
      print('Session cleared!');
    }
  }

  //check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(keyAccessToken);
    return token != null;
  }
}
