import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/theme.dart';
import '../screens/pomodoro_screen.dart';

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
