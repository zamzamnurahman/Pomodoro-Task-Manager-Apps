import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_task_manager/src/config/theme.dart';
import 'package:pomodoro_task_manager/src/presentations/screens/pomodoro_screen.dart';
import 'package:pomodoro_task_manager/src/presentations/screens/profile_screens.dart';
import 'package:pomodoro_task_manager/src/presentations/screens/task_screens.dart';

final navBottomProvider =
    StateNotifierProvider<BottomNavigationNotifier, int>((ref) {
  return BottomNavigationNotifier();
});

class BottomNavigationNotifier extends StateNotifier<int> {
  BottomNavigationNotifier() : super(0);

  changeIndex(int newIndex)=> state = newIndex;
}

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final int index = ref.watch(navBottomProvider);
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
        index: index,
        children: const [
          PomodoroScreen(),
          TaskScreens(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: primary,
        onTap: ref.watch(navBottomProvider.notifier).changeIndex,
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
