import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/core/base_class/base_view_model.dart';
import 'package:taskify/core/constants/enums.dart';
import 'package:taskify/core/strings/app_strings.dart';

class SignUpViewModel extends BaseViewModel {
  final BuildContext context;

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text controllers
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
  String? get termsError => _termsError;

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

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.requiredName;
    }

    if (value.length < 2) {
      return AppStrings.invalidName;
    }

    return null;
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

    if (value.length < 8) {
      return AppStrings.invalidPassword;
    }

    // Check for at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return AppStrings.passwordUppercaseRequired;
    }

    // Check for at least one number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return AppStrings.passwordNumberRequired;
    }

    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.requiredConfirmPassword;
    }

    if (passwordController.text != value) {
      return AppStrings.passwordMismatch;
    }

    return null;
  }

  bool validateTerms() {
    if (!_acceptedTerms) {
      _termsError = AppStrings.termsRequired;
      notifyListeners();
      return false;
    }

    _termsError = null;
    return true;
  }

  Future<void> signUp() async {
    // Clear terms error
    _termsError = null;

    // Validate form
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Validate terms separately (since it's not a TextFormField)
    if (!validateTerms()) {
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

      debugPrint(AppStrings.signUpSuccess);

      setState(ViewState.idle);
    } catch (e) {
      // Handle signup error
      debugPrint('Sign up error: $e');
      setState(ViewState.idle);

      // Show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppStrings.signUpError),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void signUpWithGoogle() {
    // TODO: Implement Google Sign-In
    debugPrint('Sign up with ${AppStrings.google}');
  }

  void signUpWithApple() {
    // TODO: Implement Apple Sign-In
    debugPrint('Sign up with ${AppStrings.apple}');
  }

  void goToLogin(BuildContext context) {
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
