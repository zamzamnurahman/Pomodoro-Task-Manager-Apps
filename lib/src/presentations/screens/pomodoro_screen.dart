import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/todo/todo_api.dart';
import '../../data/user/user_notifier.dart';
import '../widgets/timer_countdown.dart';

///[total pomodoro]
final totalProvider = StateNotifierProvider<TotalNotifier, int>((ref) {
  return TotalNotifier();
});

class TotalNotifier extends StateNotifier<int> {
  TotalNotifier() : super(1);

  setTotal(int neValue) => state = neValue;
}

///[NAVIGATION MENU]
final navProvider = StateNotifierProvider<NavNotifier, int>((ref) {
  return NavNotifier();
});

class NavNotifier extends StateNotifier<int> {
  NavNotifier() : super(0);

  setNavigation(int newIndex) => state = newIndex;
}

///[ISPLAY TIMER]
final playtimerProvider =
    StateNotifierProvider<PlayTimerNotifier, String>((ref) {
  return PlayTimerNotifier();
});

class PlayTimerNotifier extends StateNotifier<String> {
  PlayTimerNotifier() : super("not start");

  setPlay(String newValue) => state = newValue;
}

class PomodoroScreen extends ConsumerStatefulWidget {
  const PomodoroScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends ConsumerState<PomodoroScreen> {
  final CountDownController _ctrl1 = CountDownController();
  final CountDownController _ctrl2 = CountDownController();
  final CountDownController _ctrl3 = CountDownController();
  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(userProvider);
    final int index = ref.watch(navProvider);
    final timer = ref.watch(playtimerProvider.notifier);
    final String statusPlay = ref.watch(playtimerProvider);

    handleResetButton() {
      switch (index) {
        case 0:
          _ctrl1.reset();
          break;
        case 1:
          _ctrl2.reset();
          break;
        case 2:
          _ctrl3.reset();
        default:
      }
      timer.setPlay("not start");
    }

    handlePlayButton() {
      switch (index) {
        case 0:
          if (statusPlay == "not start") {
            timer.setPlay("start");
            _ctrl1.start();
          } else if (statusPlay == "start") {
            timer.setPlay("pause");
            _ctrl1.pause();
          } else {
            timer.setPlay("start");
            _ctrl1.resume();
          }
          break;
        case 1:
          if (statusPlay == "not start") {
            timer.setPlay("start");
            _ctrl2.start();
          } else if (statusPlay == "start") {
            timer.setPlay("pause");
            _ctrl2.pause();
          } else {
            timer.setPlay("start");
            _ctrl2.resume();
          }
          break;
        case 2:
          if (statusPlay == "not start") {
            timer.setPlay("start");
            _ctrl3.start();
          } else if (statusPlay == "start") {
            timer.setPlay("pause");
            _ctrl3.pause();
          } else {
            timer.setPlay("start");
            _ctrl3.resume();
          }
        default:
      }
    }

    handleNextButton() {
      if (statusPlay == "start") {
        timer.setPlay("not start");
        switch (index) {
          case 0:
            _ctrl1.reset();
            break;
          case 1:
            _ctrl2.reset();
            break;
          case 2:
            _ctrl3.reset();
          default:
        }
      }
      if (index == 2) {
        ref.watch(navProvider.notifier).setNavigation(0);
        _ctrl1.start();
        timer.setPlay('start');
      } else {
        switch (index) {
          case 0:
            ref.watch(navProvider.notifier).setNavigation(1);
            _ctrl2.start();
            timer.setPlay('start');
            break;
          case 1:
            ref.watch(navProvider.notifier).setNavigation(2);
            _ctrl3.start();
            timer.setPlay('start');
          default:
        }
      }
    }

    // final User? user = ref.watch(userProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    ref.watch(navProvider.notifier).setNavigation(0);
                  },
                  child: Text(
                    "Pomodoro",
                    style: TextStyle(
                      fontWeight: index == 0 ? FontWeight.bold : null,
                      fontSize: index == 0 ? 20 : 14,
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      ref.watch(navProvider.notifier).setNavigation(1);
                    },
                    child: Text(
                      "Break",
                      style: TextStyle(
                        fontWeight: index == 1 ? FontWeight.bold : null,
                        fontSize: index == 1 ? 20 : 14,
                      ),
                    )),
                TextButton(
                    onPressed: () {
                      ref.watch(navProvider.notifier).setNavigation(2);
                    },
                    child: Text(
                      "Istirahat",
                      style: TextStyle(
                        fontWeight: index == 2 ? FontWeight.bold : null,
                        fontSize: index == 2 ? 20 : 14,
                      ),
                    )),
              ],
            ),
            IndexedStack(
              index: index,
              children: [
                TimerPomodoro(duration: 1500, ctrl1: _ctrl1, ctrl2: _ctrl2),
                TimerPomodoro(duration: 300, ctrl1: _ctrl2, ctrl2: _ctrl3),
                TimerPomodoro(duration: 900, ctrl1: _ctrl3, ctrl2: _ctrl1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: handleResetButton,
                  child: const Text("Reset"),
                ),
                InkWell(
                  onTap: handlePlayButton,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 2,
                        )),
                    child: Icon(
                      statusPlay == "start" ? Icons.pause : Icons.play_arrow,
                      size: 30,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: handleNextButton,
                  child: const Text("Lanjut"),
                ),
              ],
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("todo")
                    .orderBy('created_at', descending: false)
                    .snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, i) {
                              final todo = snapshot.data!.docs[i];
                              if (!todo['status'] &&
                                  todo['user_id'] == user!.uid) {
                                return Dismissible(
                                  background: Container(
                                    color: Colors.red,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(Icons.delete),
                                        Icon(Icons.delete),
                                      ],
                                    ),
                                  ),
                                  key: Key(todo.id),
                                  onDismissed: (direction) {
                                    TodoApi().deleteProduct(todo);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.red,
                                            content: Text(
                                                'Tugas berhasil dihapus')));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: ListTile(
                                      title: Text(todo['title']),
                                      trailing: IconButton(
                                        onPressed: () {
                                          TodoApi().editProduct(true, todo.id);
                                        },
                                        icon: const Icon(Icons.check),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return const Visibility(
                                    visible: false, child: SizedBox());
                              }
                            }),
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Center(
                          child: Text("Tidak ada Tugas"),
                        ),
                      );
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }
}
