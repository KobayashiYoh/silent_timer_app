import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silent_timer_app/models/timer_state.dart';

final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  return TimerNotifier();
});

class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier() : super(kInitialTimerState);
  Timer? _timer;

  void onPressedPlayButton() {
    state.isActive ? _stopTimer() : _startTimer();
    state = state.copyWith(
      isActive: !state.isActive,
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        print('hoge');
      },
    );
  }

  void _stopTimer() {
    _timer?.cancel();
    print('stop');
  }
}
