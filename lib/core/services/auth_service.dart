import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/services/local_storage_service.dart';
import 'package:taskify/locator.dart';

class AuthService {
  final supabase = Supabase.instance.client;
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
        if (kDebugMode) {
          print('Signup failed - no user created');
        }
        return false;
      }

      final userId = response.user!.id;
      if (kDebugMode) {
        print('Auth user created with ID: $userId');
      }

      if (kDebugMode) {
        print('Inserting profile into database...');
      }

      await supabase.from('profiles').insert({
        'id': userId,
        'email': email,
        'name': name,
        'profile_image_url': imageUrl,
      });

      if (kDebugMode) {
        print('Profile inserted successfully');
      }

      if (response.session != null) {
        await _localStorageService.saveSession(
          accessToken: response.session!.accessToken,
          refreshToken: response.session!.refreshToken!,
          userId: response.user!.id,
        );
        if (kDebugMode) {
          print('User saved locally by signup');
        }
        return true;
      } else {
        if (kDebugMode) {
          print(
          'Signup succeeded but no session (email confirmation needed?)',
        );
        }
        return false;
      }
    } on AuthException catch (e) {
      if (kDebugMode) {
        print('Auth error: ${e.message}');
      }
      return false;
    } on PostgrestException catch (e) {
      if (kDebugMode) {
        print('Database error: ${e.message}');
      }
      if (kDebugMode) {
        print('   Code: ${e.code}');
      }
      if (kDebugMode) {
        print('   Details: ${e.details}');
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Unexpected signup error: $e');
      }
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
        if (kDebugMode) {
          print('User saved locally by login.');
        }
        return true;
      } else {
        if (kDebugMode) {
          print('No user or session in response');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
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
