import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silent_timer_app/models/timer_state.dart';

final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  return TimerNotifier();
});

class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier() : super(kInitialTimerState) {}
  int _hours = 10;
  int _minutes = 10;
  int _seconds = 10;
  Timer? _timer;

  void subtractTime() {
    int currentTotalSeconds = _hours * 3600 + _minutes * 60 + _seconds;
    int newTotalSeconds = currentTotalSeconds - 1;
    print('new total seconds: $newTotalSeconds');
    _hours = (newTotalSeconds / 3600).floor();
    _minutes = ((newTotalSeconds % 3600) / 60).floor();
    _seconds = newTotalSeconds % 60;
    print('$_hours:$_minutes:$_seconds');
  }

  void onPressedPlayButton() {
    state.isActive ? _stopTimer() : _startTimer();
    state = state.copyWith(
      isActive: !state.isActive,
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => subtractTime(),
    );
  }

  void _stopTimer() {
    _timer?.cancel();
    print('stop');
  }
}
