import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/services/local_storage_service.dart';
import 'package:taskify/locator.dart';

class AuthService {
  final supabase = Supabase.instance.client;
  final LocalStorageService _localStorageService = locator
      .get<LocalStorageService>();

  //signup
  Future<bool> signUp(String email, String password, String name) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
      if (response.user != null && response.session != null) {
        await _localStorageService.saveSession(
          accessToken: response.session!.accessToken,
          refreshToken: response.session!.refreshToken!,
          userId: response.user!.id,
        );
        print('User saved locally by signup.');
        return true;
      } else {
        print('Signup succeeded but no session (email confirmation needed?)');
        return false;
      }
    } catch (e) {
      print(' Signup error: $e');
      return false;
    }
  }

  //login
  Future<bool> logIn(String email, String password) async {
    try {
      print('🔍 Attempting login...');

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
        print('User saved locally by login.');
        return true;
      } else {
        print('No user or session in response');
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<void> logOut() async {
    try {
      await supabase.auth.signOut();
      await _localStorageService.clearSession();
      print('Logged out successfully');
    } catch (e) {
      print('Logout error: $e');
    }
  }
}
