import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/core/base_class/base_view_model.dart';
import 'package:taskify/core/constants/enums.dart';

class LoginViewModel extends BaseViewModel {
  final BuildContext context;

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
  String? _emailError;
  String? _passwordError;

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
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;

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

  bool _validateEmail(String email) {
    if (email.isEmpty) {
      _emailError = 'Email is required';
      return false;
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email)) {
      _emailError = 'Enter a valid email';
      return false;
    }

    _emailError = null;
    return true;
  }

  bool _validatePassword(String password) {
    if (password.isEmpty) {
      _passwordError = 'Password is required';
      return false;
    }

    if (password.length < 6) {
      _passwordError = 'Password must be at least 6 characters';
      return false;
    }

    _passwordError = null;
    return true;
  }

  Future<void> login() async {
    // Clear previous errors
    _emailError = null;
    _passwordError = null;
    notifyListeners();

    // Validate inputs
    final isEmailValid = _validateEmail(emailController.text);
    final isPasswordValid = _validatePassword(passwordController.text);

    if (!isEmailValid || !isPasswordValid) {
      notifyListeners();
      return;
    }

    // Start loading
    setState(ViewState.busy);

    try {
      // TODO: Implement your actual login logic here
      // Example:
      // await authService.login(
      //   email: emailController.text,
      //   password: passwordController.text,
      // );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Navigate to home screen
      // TODO: Update with your actual navigation
      context.goNamed('home');

      debugPrint('Login successful!');

      setState(ViewState.idle);
    } catch (e) {
      // Handle login error
      _passwordError = 'Invalid email or password';
      debugPrint('Login error: $e');
      setState(ViewState.idle);
      notifyListeners();
    }
  }

  void loginWithGoogle() {
    // TODO: Implement Google Sign-In
    debugPrint('Login with Google');
  }

  void loginWithApple() {
    // TODO: Implement Apple Sign-In
    debugPrint('Login with Apple');
  }

  void goToForgotPassword() {
    // TODO: Navigate to forgot password screen
    // context.goNamed('forgot-password');
    debugPrint('Navigate to Forgot Password');
  }

  void goToSignUp(BuildContext context) {
    // TODO: Navigate to signup screen
    context.goNamed('signup');
    debugPrint('Navigate to Sign Up');
  }

  void goBack(BuildContext context) {
    context.pop();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
