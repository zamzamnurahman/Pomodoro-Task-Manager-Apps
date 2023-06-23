import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_task_manager/src/config/theme.dart';

final navProvider = StateNotifierProvider<NavNotifier, int>((ref) {
  return NavNotifier();
});

class NavNotifier extends StateNotifier<int> {
  NavNotifier() : super(0);

  setNavigation(int newIndex) => state = newIndex;
}

class PomodoroScreen extends ConsumerStatefulWidget {
  const PomodoroScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends ConsumerState<PomodoroScreen> {
  int duration = 1500;
  final CountDownController _ctrl = CountDownController();
  @override
  Widget build(BuildContext context) {
    final int _index = ref.watch(navProvider);
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
                    child: Text("Pomodoro")),
                TextButton(
                    onPressed: () {
                      ref.watch(navProvider.notifier).setNavigation(1);
                    },
                    child: Text("Break")),
                TextButton(
                    onPressed: () {
                      ref.watch(navProvider.notifier).setNavigation(2);
                    },
                    child: Text("Istirahat")),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: CircularCountDownTimer(
                duration: 5,
                initialDuration: 0,
                controller: _ctrl,
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
                  debugPrint('Countdown Ended');
                  _ctrl.restart();
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => _ctrl.reset(),
                  child: const Text("Reset"),
                ),
                InkWell(
                  onTap: () {
                    _ctrl.restart();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 2,
                        )),
                    child: const Icon(Icons.play_arrow, size: 30),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        duration = 300;
                      });

                      _ctrl.restart();
                    },
                    child: const Text("Lanjut")),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _ctrl.restart();
        },
        child: const Icon(Icons.start),
      ),
    );
  }
}
