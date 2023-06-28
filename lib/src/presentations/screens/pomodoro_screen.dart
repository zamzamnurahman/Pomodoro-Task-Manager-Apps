import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_task_manager/src/config/theme.dart';

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
    final timer = ref.watch(playtimerProvider.notifier);
    final int _index = ref.watch(navProvider);
    final int total = ref.watch(totalProvider);
    final String statusPlay = ref.watch(playtimerProvider);
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
                      fontWeight: _index == 0 ? FontWeight.bold : null,
                      fontSize: _index == 0 ? 20 : 14,
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
                        fontWeight: _index == 1 ? FontWeight.bold : null,
                        fontSize: _index == 1 ? 20 : 14,
                      ),
                    )),
                TextButton(
                    onPressed: () {
                      ref.watch(navProvider.notifier).setNavigation(2);
                    },
                    child: Text(
                      "Istirahat",
                      style: TextStyle(
                        fontWeight: _index == 2 ? FontWeight.bold : null,
                        fontSize: _index == 2 ? 20 : 14,
                      ),
                    )),
              ],
            ),
            IndexedStack(
              index: _index,
              children: [
                TimerPomodoro(duration: 5, ctrl1: _ctrl1, ctrl2: _ctrl2),
                TimerPomodoro(duration: 8, ctrl1: _ctrl2, ctrl2: _ctrl3),
                TimerPomodoro(duration: 10, ctrl1: _ctrl3, ctrl2: _ctrl1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    print(_index);
                    switch (_index) {
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
                  },
                  child: const Text("Reset"),
                ),
                InkWell(
                  onTap: () {
                    switch (_index) {
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
                  },
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
                    onPressed: () {
                      if (statusPlay == "start") {
                        timer.setPlay("not start");
                        switch (_index) {
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
                      if (_index == 2) {
                        ref.watch(navProvider.notifier).setNavigation(0);
                        _ctrl1.start();
                        timer.setPlay('start');
                      } else {
                        switch (_index) {
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
                    },
                    child: const Text("Lanjut")),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TimerPomodoro extends ConsumerWidget {
  const TimerPomodoro({
    super.key,
    required CountDownController ctrl1,
    required CountDownController ctrl2,
    required this.duration,
  })  : _ctrl1 = ctrl1,
        _ctrl2 = ctrl2;

  final CountDownController _ctrl1;
  final CountDownController _ctrl2;
  final int duration;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: CircularCountDownTimer(
        duration: duration,
        initialDuration: 0,
        controller: _ctrl1,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.5,
        ringColor: Colors.white,
        fillColor: primary,
        strokeWidth: 23.0,
        strokeCap: StrokeCap.round,
        textStyle: const TextStyle(
          // fontFamily: "Digital",
          fontSize: 90.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        textFormat: CountdownTextFormat.MM_SS,
        isReverse: true,
        isReverseAnimation: true,
        isTimerTextShown: true,
        autoStart: false,
        onStart: () {
          debugPrint('Countdown Started');
        },
        onComplete: () {
          ref.watch(playtimerProvider.notifier).setPlay('not start');
          final index = ref.watch(navProvider);
          final int total = ref.watch(totalProvider);
          if (total == 2) {
            ref.watch(navProvider.notifier).setNavigation(0);
            ref.watch(totalProvider.notifier).setTotal(total + 1);
          } else {
            ref.watch(totalProvider.notifier).setTotal(total + 1);
            if (index == 2) {
              ref.watch(navProvider.notifier).setNavigation(0);
              ref.watch(totalProvider.notifier).setTotal(1);
            } else {
              ref.watch(navProvider.notifier).setNavigation(index + 1);
            }
          }
        },
        onChange: (String timeStamp) {
          debugPrint('Countdown Changed $timeStamp');
        },
        timeFormatterFunction: (defaultFormatterFunction, duration) {
          if (duration.inSeconds == 0) {
            return "Finish";
          } else {
            return Function.apply(defaultFormatterFunction, [duration]);
          }
        },
      ),
    );
  }
}
