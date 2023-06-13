import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro_task_manager/src/presentations/widgets/logo.dart';

class AuthenticationScreen extends ConsumerWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            ElevatedButton.icon(
              onPressed: () {
                GoRouter.of(context).pushReplacementNamed("/home");
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
            )
          ],
        ),
      ),
    );
  }
}
