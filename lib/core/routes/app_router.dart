import 'package:go_router/go_router.dart';
import 'package:taskify/ui/screens/add_task/add_task_view.dart';
import 'package:taskify/ui/screens/auth/login/login_view.dart';
import 'package:taskify/ui/screens/auth/signup/signup_view.dart';
import 'package:taskify/ui/screens/home/home_view.dart';
import 'package:taskify/ui/screens/onboarding/onboarding_view.dart';
import 'package:taskify/ui/screens/splash/splash_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => SplashView(),
    ),

    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
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
      builder: (context, state) => SignUpView(),
    ),

    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => HomeView(),
    ),

    GoRoute(
      path: '/addTask',
      name: 'addTask',
      builder: (context, state) => AddTaskView(),
    ),
  ],
);
