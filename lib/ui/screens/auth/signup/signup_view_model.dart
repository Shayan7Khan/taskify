import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/core/base_class/base_view_model.dart';
import 'package:taskify/core/constants/enums.dart';

class SignUpViewModel extends BaseViewModel {
  final BuildContext context;

  // Text controllers
  final GlobalKey _formkey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Animation states
  double _bubbleScale = 0.8;
  double _backButtonOpacity = 0.0;
  double _headerOpacity = 0.0;
  double _nameFieldOpacity = 0.0;
  double _emailFieldOpacity = 0.0;
  double _passwordFieldOpacity = 0.0;
  double _confirmPasswordFieldOpacity = 0.0;
  double _termsOpacity = 0.0;
  double _buttonScale = 0.0;
  double _dividerOpacity = 0.0;
  double _socialButtonsOpacity = 0.0;
  double _loginRedirectOpacity = 0.0;

  Offset _headerOffset = const Offset(0, 0.3);
  Offset _nameFieldOffset = const Offset(-0.3, 0);
  Offset _emailFieldOffset = const Offset(-0.3, 0);
  Offset _passwordFieldOffset = const Offset(-0.3, 0);
  Offset _confirmPasswordFieldOffset = const Offset(-0.3, 0);
  Offset _socialButtonsOffset = const Offset(0, 0.3);

  // Form states
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _termsError;

  // Getters
  double get bubbleScale => _bubbleScale;
  double get backButtonOpacity => _backButtonOpacity;
  double get headerOpacity => _headerOpacity;
  double get nameFieldOpacity => _nameFieldOpacity;
  double get emailFieldOpacity => _emailFieldOpacity;
  double get passwordFieldOpacity => _passwordFieldOpacity;
  double get confirmPasswordFieldOpacity => _confirmPasswordFieldOpacity;
  double get termsOpacity => _termsOpacity;
  double get buttonScale => _buttonScale;
  double get dividerOpacity => _dividerOpacity;
  double get socialButtonsOpacity => _socialButtonsOpacity;
  double get loginRedirectOpacity => _loginRedirectOpacity;

  Offset get headerOffset => _headerOffset;
  Offset get nameFieldOffset => _nameFieldOffset;
  Offset get emailFieldOffset => _emailFieldOffset;
  Offset get passwordFieldOffset => _passwordFieldOffset;
  Offset get confirmPasswordFieldOffset => _confirmPasswordFieldOffset;
  Offset get socialButtonsOffset => _socialButtonsOffset;

  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  bool get acceptedTerms => _acceptedTerms;
  String? get nameError => _nameError;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  String? get confirmPasswordError => _confirmPasswordError;
  String? get termsError => _termsError;

  GlobalKey get formKey => _formkey;

  SignUpViewModel(this.context) {
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

    // Name field
    await Future.delayed(const Duration(milliseconds: 150));
    _nameFieldOpacity = 1.0;
    _nameFieldOffset = const Offset(0, 0);
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

    // Confirm password field
    await Future.delayed(const Duration(milliseconds: 150));
    _confirmPasswordFieldOpacity = 1.0;
    _confirmPasswordFieldOffset = const Offset(0, 0);
    notifyListeners();

    // Terms checkbox
    await Future.delayed(const Duration(milliseconds: 100));
    _termsOpacity = 1.0;
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

    // Login redirect
    await Future.delayed(const Duration(milliseconds: 150));
    _loginRedirectOpacity = 1.0;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  void toggleTerms() {
    _acceptedTerms = !_acceptedTerms;
    _termsError = null;
    notifyListeners();
  }

  bool _validateName(String name) {
    if (name.isEmpty) {
      _nameError = 'Name is required';
      return false;
    }

    if (name.length < 2) {
      _nameError = 'Name must be at least 2 characters';
      return false;
    }

    _nameError = null;
    return true;
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

    if (password.length < 8) {
      _passwordError = 'Password must be at least 8 characters';
      return false;
    }

    // Check for at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      _passwordError = 'Password must contain at least one uppercase letter';
      return false;
    }

    // Check for at least one number
    if (!password.contains(RegExp(r'[0-9]'))) {
      _passwordError = 'Password must contain at least one number';
      return false;
    }

    _passwordError = null;
    return true;
  }

  bool _validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      _confirmPasswordError = 'Please confirm your password';
      return false;
    }

    if (password != confirmPassword) {
      _confirmPasswordError = 'Passwords do not match';
      return false;
    }

    _confirmPasswordError = null;
    return true;
  }

  bool _validateTerms() {
    if (!_acceptedTerms) {
      _termsError = 'You must accept the terms and conditions';
      return false;
    }

    _termsError = null;
    return true;
  }

  Future<void> signUp() async {
    // Clear previous errors
    _nameError = null;
    _emailError = null;
    _passwordError = null;
    _confirmPasswordError = null;
    _termsError = null;
    notifyListeners();

    // Validate inputs
    final isNameValid = _validateName(nameController.text);
    final isEmailValid = _validateEmail(emailController.text);
    final isPasswordValid = _validatePassword(passwordController.text);
    final isConfirmPasswordValid = _validateConfirmPassword(
      passwordController.text,
      confirmPasswordController.text,
    );
    final isTermsValid = _validateTerms();

    if (!isNameValid ||
        !isEmailValid ||
        !isPasswordValid ||
        !isConfirmPasswordValid ||
        !isTermsValid) {
      notifyListeners();
      return;
    }

    // Start loading
    setState(ViewState.busy);

    try {
      // TODO: Implement your actual signup logic here
      // Example:
      // await authService.signUp(
      //   name: nameController.text,
      //   email: emailController.text,
      //   password: passwordController.text,
      // );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Navigate to home or verification screen
      // TODO: Update with your actual navigation
      // context.goNamed('home');
      // or
      // context.goNamed('email-verification');

      debugPrint('Sign up successful!');

      setState(ViewState.idle);
    } catch (e) {
      // Handle signup error
      _emailError = 'This email is already registered';
      debugPrint('Sign up error: $e');
      setState(ViewState.idle);
      notifyListeners();
    }
  }

  void signUpWithGoogle() {
    // TODO: Implement Google Sign-In
    debugPrint('Sign up with Google');
  }

  void signUpWithApple() {
    // TODO: Implement Apple Sign-In
    debugPrint('Sign up with Apple');
  }

  void goToLogin(BuildContext context) {
    // TODO: Navigate to login screen
    context.goNamed('login');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
