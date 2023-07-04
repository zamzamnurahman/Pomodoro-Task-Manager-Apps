import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_task_manager/src/data/authentication.dart';
import 'package:pomodoro_task_manager/src/data/user/user_notifier.dart';
import 'package:pomodoro_task_manager/src/presentations/screens/main_screen.dart';
import 'package:pomodoro_task_manager/src/presentations/screens/pomodoro_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(userProvider);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              leading: Container(
                child: user?.photoURL == null
                    ? const Icon(Icons.person, size: 50)
                    : Image.network(
                        user!.photoURL!,
                        errorBuilder: (_, object, error) {
                          return const Icon(Icons.person);
                        },
                      ),
              ),
              title: Text(user!.displayName!),
              subtitle: Text(user.email!),
            ),
          ),
          const SizedBox(height: 10),
          const Spacer(),
          TextButton.icon(
            onPressed: () {
              Authentication.signOut(context: context);
              ref.invalidate(navBottomProvider);
              ref.invalidate(navProvider);
              ref.invalidate(playtimerProvider);
            },
            label: const Text("Keluar"),
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ));
  }
}
