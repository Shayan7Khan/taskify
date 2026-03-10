import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/logge_customizations/custom_logger.dart';
import 'package:taskify/core/services/database_service.dart';
import 'package:taskify/core/services/local_storage_service.dart';
import 'package:taskify/locator.dart';

class AuthService {
  final CustomLogger log = CustomLogger(className: 'AuthService');
  final supabase = Supabase.instance.client;
  final DatabaseService _databaseService = locator.get<DatabaseService>();
  final LocalStorageService _localStorageService = locator
      .get<LocalStorageService>();

  //signup
  Future<bool> signUp(
    String email,
    String password,
    String name,
    String? imageUrl,
  ) async {
    try {
      if (kDebugMode) {
        print('Starting signup for: $email');
      }
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user == null) {
        log.d('Signup failed - no user created');
        return false;
      }
      final userId = response.user!.id;
      log.d('Auth user created with ID: $userId');
      log.d('Inserting profile into database...');
      await supabase.from('profiles').insert({
        'id': userId,
        'email': email,
        'name': name,
        'profile_image_url': imageUrl,
      });
      log.d('Profile inserted successfully');
      if (response.session != null) {
        await _localStorageService.saveSession(
          accessToken: response.session!.accessToken,
          refreshToken: response.session!.refreshToken!,
          userId: response.user!.id,
        );
        log.d('User saved locally by signup');
        await _databaseService.saveDeviceToken();
        return true;
      } else {
        log.d('Signup succeeded but no session (email confirmation needed?)');
        return false;
      }
    } on AuthException catch (e) {
      if (kDebugMode) {
        print('Auth error: ${e.message}');
      }
      return false;
    } on PostgrestException catch (e) {
      log.d('Database error: ${e.message}');
      log.d('Code: ${e.code}');
      log.d('Details: ${e.details}');
      return false;
    } catch (e) {
      log.e('Unexpected signup error: $e');
      return false;
    }
  }

  //login
  Future<bool> logIn(String email, String password) async {
    try {
      if (kDebugMode) {
        print(' Attempting login...');
      }
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null && response.session != null) {
        await _localStorageService.saveSession(
          accessToken: response.session!.accessToken,
          refreshToken: response.session!.refreshToken!,
          userId: response.user!.id,
        );
        log.d('User saved locally by login.');
        await _databaseService.saveDeviceToken();
        return true;
      } else {
        log.d('No user or session in response');
        return false;
      }
    } catch (e) {
      log.e('Login error: $e');
      return false;
    }
  }

  //logout
  Future<void> logOut() async {
    try {
      await supabase.auth.signOut();
      await _localStorageService.clearSession();
      if (kDebugMode) {
        print('Logged out successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Logout error: $e');
      }
    }
  }
}
