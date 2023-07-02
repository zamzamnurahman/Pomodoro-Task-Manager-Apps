import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro_task_manager/src/data/user/user_notifier.dart';
import 'package:pomodoro_task_manager/src/presentations/widgets/logo.dart';

import '../../data/authentication.dart';

class AuthenticationScreen extends ConsumerWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(userProvider.notifier);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Logo(),
            Stack(
              children: [
                const Text(
                  "Mulai dari\nSekarang\nAtur Waktu\nProduktivitas",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                Text(
                  "Mulai dari\nSekarang\nAtur Waktu\nProduktivitas",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = Colors.white,
                  ),
                ),
              ],
            ),
            const Text(
              "Pomodoro Task Manager, membatu kamu dalam produktivitas belajar menggunakan teknik Pomodoro.",
            ),
            FutureBuilder(
              future: Authentication().initializeFirebase(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Error initializing Firebase');
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return ElevatedButton.icon(
                    onPressed: () async {
                      final isSignIn = await auth.getUser(context);

                      // User? user = await Authentication.signInWithGoogle(
                      //   context: context,
                      // );
                      //
                      if (isSignIn) {
                        if (!context.mounted) return;
                        GoRouter.of(context).pushReplacementNamed("/home");
                      }
                    },
                    icon: SvgPicture.asset("assets/google.svg"),
                    label: const Text("Masuk dengan Google"),
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  );
                }
                return const SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
