import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_task_manager/src/config/theme.dart';
import 'package:pomodoro_task_manager/src/presentations/screens/pomodoro_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Pomodoro Task Manager",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: IndexedStack(
        index: 0,
        children: [
          PomodoroScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: primary,
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(
            label: "Pomodoro",
            icon: Icon(
              Icons.timer,
            ),
          ),
          BottomNavigationBarItem(
            label: "Tugas",
            icon: Icon(
              Icons.task_alt,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profil",
            icon: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
    );
  }
}
