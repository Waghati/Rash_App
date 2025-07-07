import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../screens/landing/landing_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/dashboards/student_dashboard.dart';
import '../screens/dashboards/teacher_dashboard.dart';
import '../screens/dashboards/parent_dashboard.dart';
import '../screens/shared/splash_screen.dart';
import '../utils/constants.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppConstants.landingRoute,
    routes: [
      // Splash Screen
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Landing Page
      GoRoute(
        path: AppConstants.landingRoute,
        name: 'landing',
        builder: (context, state) => const LandingScreen(),
      ),

      // Authentication Routes
      GoRoute(
        path: AppConstants.loginRoute,
        name: 'login',
        builder: (context, state) {
          final userType = state.uri.queryParameters['type'] ?? 'student';
          return LoginScreen(userType: userType);
        },
      ),

      GoRoute(
        path: AppConstants.registerRoute,
        name: 'register',
        builder: (context, state) {
          final userType = state.uri.queryParameters['type'] ?? 'student';
          return RegisterScreen(userType: userType);
        },
      ),

      // Dashboard Routes
      GoRoute(
        path: AppConstants.studentDashboardRoute,
        name: 'student-dashboard',
        builder: (context, state) => const StudentDashboard(),
      ),

      GoRoute(
        path: AppConstants.teacherDashboardRoute,
        name: 'teacher-dashboard',
        builder: (context, state) => const TeacherDashboard(),
      ),

      GoRoute(
        path: AppConstants.parentDashboardRoute,
        name: 'parent-dashboard',
        builder: (context, state) => const ParentDashboard(),
      ),
    ],

    // Error handling
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found: ${state.uri}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppConstants.landingRoute),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}