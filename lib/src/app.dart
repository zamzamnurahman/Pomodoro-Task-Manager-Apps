import 'package:flutter/material.dart';
import 'package:pomodoro_task_manager/src/config/router.dart';
import 'package:pomodoro_task_manager/src/config/theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: AppRoutes.goRouter.routeInformationParser,
      routeInformationProvider: AppRoutes.goRouter.routeInformationProvider,
      routerDelegate: AppRoutes.goRouter.routerDelegate,
      theme: themeData,
    );
  }
}
