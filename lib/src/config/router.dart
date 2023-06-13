import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro_task_manager/src/presentations/screens/authentication_screen.dart';
import 'package:pomodoro_task_manager/src/presentations/screens/home_screen.dart';
import 'package:pomodoro_task_manager/src/presentations/screens/splash_screen.dart';

class AppRoutes {
  static const String splashscreen = "/splash";
  static const String authScreen = "/auth";
  static const String homescreen = "/home";

  static Page _splashScreenBuilder(BuildContext context, GoRouterState state) {
    return const MaterialPage(
      child: SplashScreen(),
    );
  }

  static Page _authScreenBuilder(BuildContext context, GoRouterState state) {
    return const MaterialPage(
      child: AuthenticationScreen(),
    );
  }

  static Page _homeScreenBuilder(BuildContext context, GoRouterState state) {
    return const MaterialPage(
      child: HomeScreen(),
    );
  }

  static GoRouter goRouter = GoRouter(
    initialLocation: splashscreen,
    routes: [
      GoRoute(
        name: splashscreen,
        path: splashscreen,
        pageBuilder: _splashScreenBuilder,
      ),
      GoRoute(
        name: authScreen,
        path: authScreen,
        pageBuilder: _authScreenBuilder,
      ),
      GoRoute(
        name: homescreen,
        path: homescreen,
        pageBuilder: _homeScreenBuilder,
      ),
    ],
  );
}
