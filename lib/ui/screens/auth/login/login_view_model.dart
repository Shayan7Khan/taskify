import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/core/base_class/base_view_model.dart';
import 'package:taskify/core/constants/enums/view_state.dart';
import 'package:taskify/core/services/auth_service.dart';
import 'package:taskify/core/constants/strings/app_strings.dart';
import 'package:taskify/locator.dart';

class LoginViewModel extends BaseViewModel {
  final BuildContext context;

  final AuthService _authService = locator<AuthService>();
  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Animation states
  double _bubbleScale = 0.8;
  double _backButtonOpacity = 0.0;
  double _headerOpacity = 0.0;
  double _emailFieldOpacity = 0.0;
  double _passwordFieldOpacity = 0.0;
  double _forgotPasswordOpacity = 0.0;
  double _buttonScale = 0.0;
  double _dividerOpacity = 0.0;
  double _socialButtonsOpacity = 0.0;
  double _signupRedirectOpacity = 0.0;

  Offset _headerOffset = const Offset(0, 0.3);
  Offset _emailFieldOffset = const Offset(-0.3, 0);
  Offset _passwordFieldOffset = const Offset(-0.3, 0);
  Offset _socialButtonsOffset = const Offset(0, 0.3);

  // Form states
  bool _obscurePassword = true;

  // Getters
  double get bubbleScale => _bubbleScale;
  double get backButtonOpacity => _backButtonOpacity;
  double get headerOpacity => _headerOpacity;
  double get emailFieldOpacity => _emailFieldOpacity;
  double get passwordFieldOpacity => _passwordFieldOpacity;
  double get forgotPasswordOpacity => _forgotPasswordOpacity;
  double get buttonScale => _buttonScale;
  double get dividerOpacity => _dividerOpacity;
  double get socialButtonsOpacity => _socialButtonsOpacity;
  double get signupRedirectOpacity => _signupRedirectOpacity;

  Offset get headerOffset => _headerOffset;
  Offset get emailFieldOffset => _emailFieldOffset;
  Offset get passwordFieldOffset => _passwordFieldOffset;
  Offset get socialButtonsOffset => _socialButtonsOffset;

  bool get obscurePassword => _obscurePassword;

  LoginViewModel(this.context) {
    _startAnimations();
  }

  void _startAnimations() async {
    // Bubble scale
    await Future.delayed(const Duration(milliseconds: 100));
    _bubbleScale = 1.0;
    notifyListeners();

    // Back button
    await Future.delayed(const Duration(milliseconds: 150));
    _backButtonOpacity = 1.0;
    notifyListeners();

    // Header
    await Future.delayed(const Duration(milliseconds: 200));
    _headerOpacity = 1.0;
    _headerOffset = const Offset(0, 0);
    notifyListeners();

    // Email field
    await Future.delayed(const Duration(milliseconds: 150));
    _emailFieldOpacity = 1.0;
    _emailFieldOffset = const Offset(0, 0);
    notifyListeners();

    // Password field
    await Future.delayed(const Duration(milliseconds: 150));
    _passwordFieldOpacity = 1.0;
    _passwordFieldOffset = const Offset(0, 0);
    notifyListeners();

    // Forgot password
    await Future.delayed(const Duration(milliseconds: 100));
    _forgotPasswordOpacity = 1.0;
    notifyListeners();

    // Button
    await Future.delayed(const Duration(milliseconds: 150));
    _buttonScale = 1.0;
    notifyListeners();

    // Divider
    await Future.delayed(const Duration(milliseconds: 150));
    _dividerOpacity = 1.0;
    notifyListeners();

    // Social buttons
    await Future.delayed(const Duration(milliseconds: 150));
    _socialButtonsOpacity = 1.0;
    _socialButtonsOffset = const Offset(0, 0);
    notifyListeners();

    // Signup redirect
    await Future.delayed(const Duration(milliseconds: 150));
    _signupRedirectOpacity = 1.0;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.requiredEmail;
    }

    if (!RegExp(AppStrings.emailRegex).hasMatch(value)) {
      return AppStrings.invalidEmail;
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.requiredPassword;
    }

    if (value.length < 6) {
      return AppStrings.invalidPassword;
    }

    return null;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    setState(ViewState.busy);
    bool success = await _authService.logIn(
      emailController.text,
      passwordController.text,
    );
    setState(ViewState.idle);
    if (!context.mounted) return;
    if (success) {
      debugPrint(AppStrings.loginSuccess);
      context.goNamed('home');
    } else {
      debugPrint('Login failed');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.loginError),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void loginWithGoogle() {
    // TODO: Implement Google Sign-In
    debugPrint('Login with ${AppStrings.google}');
  }

  void loginWithApple() {
    // TODO: Implement Apple Sign-In
    debugPrint('Login with ${AppStrings.apple}');
  }

  void goToForgotPassword() {
    // TODO: Navigate to forgot password screen
    // context.goNamed('forgot-password');
    debugPrint('Navigate to Forgot Password');
  }

  void goToSignUp(BuildContext context) {
    context.goNamed('signup');
    debugPrint('Navigate to Sign Up');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
