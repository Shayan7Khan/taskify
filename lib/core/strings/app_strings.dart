class AppStrings {
  AppStrings._();

  static const String emailRegex =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String passwordRegex = r'^.{8,}$';

  // Email Validation
  static const String requiredEmail = 'Email is required';
  static const String invalidEmail = 'Enter a valid email';

  // Password Validation
  static const String requiredPassword = 'Password is required';
  static const String invalidPassword =
      'Password must be at least 8 characters';
  static const String passwordUppercaseRequired =
      'Password must contain at least one uppercase letter';
  static const String passwordNumberRequired =
      'Password must contain at least one number';

  // Name Validation
  static const String requiredName = 'Name is required';
  static const String invalidName = 'Name must be at least 2 characters';

  // Confirm Password Validation
  static const String requiredConfirmPassword = 'Please confirm your password';
  static const String passwordMismatch = 'Passwords do not match';

  // Terms & Conditions Validation
  static const String termsRequired =
      'You must accept the terms and conditions';

  // Login Screen
  static const String welcomeBack = 'Welcome Back';
  static const String loginSubtitle =
      'Login to continue your productivity journey';
  static const String login = 'Login';
  static const String loggingIn = 'Logging in...';
  static const String forgotPassword = 'Forgot Password?';
  static const String dontHaveAccount = "Don't have an account? ";

  // Sign Up Screen
  static const String createAccount = 'Create Account';
  static const String signUpSubtitle = 'Sign up to start organizing your tasks';
  static const String signUp = 'Sign Up';
  static const String creatingAccount = 'Creating Account...';
  static const String alreadyHaveAccount = 'Already have an account? ';
  static const String termsAgreement = 'I agree to the ';
  static const String termsAndConditions = 'Terms & Conditions';
  static const String and = ' and ';
  static const String privacyPolicy = 'Privacy Policy';

  //  Form Fields
  static const String fullName = 'Full Name';
  static const String enterFullName = 'Enter your full name';
  static const String email = 'Email';
  static const String enterEmail = 'Enter your email';
  static const String password = 'Password';
  static const String enterPassword = 'Enter your password';
  static const String createPassword = 'Create a password';
  static const String confirmPassword = 'Confirm Password';
  static const String reEnterPassword = 'Re-enter your password';

  // Social Login
  static const String orDivider = 'OR';
  static const String google = 'Google';
  static const String apple = 'Apple';

  //  Error Messages
  static const String loginError = 'Invalid email or password';
  static const String signUpError = 'This email is already registered';
  static const String networkError = 'Network error. Please try again.';
  static const String genericError = 'Something went wrong. Please try again.';

  //  Success Messages
  static const String loginSuccess = 'Login successful!';
  static const String signUpSuccess = 'Sign up successful!';

  //logout
  static const String logoutTitle = 'Logout';
  static const String logoutMessage = 'Are you sure you want to logout?';
  static const String logoutCancel = 'Cancel';
  static const String logoutSuccess = 'Logged out successfully';
  static const String logoutError = 'Failed to logout. Please try again.';
}
