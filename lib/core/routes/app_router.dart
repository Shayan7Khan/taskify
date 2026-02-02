import 'package:go_router/go_router.dart';
import 'package:taskify/ui/screens/auth/login/login_view.dart';
import 'package:taskify/ui/screens/auth/signup/signup_view.dart';
import 'package:taskify/ui/screens/home_view/home_view.dart';
import 'package:taskify/ui/screens/onboarding/onboarding_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(
      path: '/onboarding',
      name: 'onboardig',
      builder: (context, state) => OnboardingView(),
    ),

    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => LoginView(),
    ),

    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => SignupView(),
    ),

    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => HomeView(),
    ),
  ],
);
