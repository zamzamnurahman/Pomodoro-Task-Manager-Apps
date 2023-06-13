import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_task_manager/src/config/theme.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
