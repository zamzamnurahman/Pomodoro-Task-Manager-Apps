import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro_task_manager/src/data/authentication.dart';
import 'package:pomodoro_task_manager/src/data/user/user_notifier.dart';
import 'package:pomodoro_task_manager/src/presentations/widgets/logo.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) async{
      ref.watch(userProvider.notifier).setUser().then((value) {
        if(value is User){
          context.goNamed('/home');
        }else{
          context.goNamed('/auth');
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Logo(isAnimation: true),
    ));
  }
}
