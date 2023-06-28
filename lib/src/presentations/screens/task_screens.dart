import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_task_manager/src/data/todo/todo_api.dart';

class TaskScreens extends ConsumerWidget {
  const TaskScreens({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            TodoApi().uploadingData(title: "testing #1");
          },
          label: Text("Tambah Todo"),
          icon: Icon(Icons.add),
        ),
      ],
    ));
  }
}
