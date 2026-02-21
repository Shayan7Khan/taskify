import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/core/base_class/base_view_model.dart';
import 'package:taskify/core/constants/enums/view_state.dart';
import 'package:taskify/core/services/auth_service.dart';
import 'package:taskify/core/services/image_picker_service.dart';
import 'package:taskify/core/services/supabase_storgae_service.dart';

import 'package:taskify/core/constants/strings/app_strings.dart';
import 'package:taskify/locator.dart';
import 'package:image_picker/image_picker.dart';

class SignUpViewModel extends BaseViewModel {
  final BuildContext context;

  final AuthService _authService = locator<AuthService>();
  final ImagePickerService _imageService = locator<ImagePickerService>();
  final SupabaseStorgaeService _storageService =
      locator<SupabaseStorgaeService>();

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Profile Image
  File? _profileImage;
  File? get profileImage => _profileImage;

  // Animation states
  double _bubbleScale = 0.8;
  double _backButtonOpacity = 0.0;
  double _headerOpacity = 0.0;
  double _imagePickerOpacity = 0.0;
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
  Offset _imagePickerOffset = const Offset(0, 0.3);
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
  double get imagePickerOpacity => _imagePickerOpacity;
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
  Offset get imagePickerOffset => _imagePickerOffset; 
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

    // Image picker - Add this
    await Future.delayed(const Duration(milliseconds: 150));
    _imagePickerOpacity = 1.0;
    _imagePickerOffset = const Offset(0, 0);
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

  /// Show dialog to let user choose between camera or gallery
  Future<void> pickProfileImage(BuildContext context) async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Image Source'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: Color(0xFF4C766E),
              ),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF4C766E)),
              title: const Text('Camera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;
    File? pickedImage;
    if (source == ImageSource.gallery) {
      pickedImage = await _imageService.pickImageFromGallery();
    } else {
      pickedImage = await _imageService.pickImageFromCamera();
    }

    if (pickedImage != null) {
      _profileImage = pickedImage;
      notifyListeners();
    }
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

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return AppStrings.passwordUppercaseRequired;
    }

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
    _termsError = null;
    // Validate form
    if (!formKey.currentState!.validate()) {
      return;
    }
    // Validate terms
    if (!validateTerms()) {
      return;
    }
    setState(ViewState.busy);
    try {
      String? imageUrl;
      // Upload profile image if user selected one
      if (_profileImage != null) {
        imageUrl = await _storageService.uploadProfileImage(
          _profileImage!,
          emailController.text.trim(), 
        );
        if (imageUrl == null) {
          throw 'Failed to upload profile image';
        }
      }

      bool success = await _authService.signUp(
        emailController.text.trim(),
        passwordController.text.trim(),
        nameController.text.trim(),
        imageUrl,
      );
      setState(ViewState.idle);
      if (!context.mounted) return;
      if (success) {
        debugPrint(AppStrings.signUpSuccess);
        context.goNamed('home');
      } else {
        throw 'Sign up failed';
      }
    } catch (e) {
      setState(ViewState.idle);
      if (!context.mounted) return;
      debugPrint('Sign up error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  void signUpWithGoogle() {
    debugPrint('Sign up with ${AppStrings.google}');
  }

  void signUpWithApple() {
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
