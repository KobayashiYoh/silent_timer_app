import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silent_timer_app/extensions/int_extension.dart';
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

  int get _currentTotalTime => _hours * 3600 + _minutes * 60 + _seconds;
  String get _timeText {
    String hoursText = _hours > 9 ? '$_hours' : '0$_hours';
    String minutesText = _minutes > 9 ? '$_minutes' : '0$_minutes';
    String secondsText = _seconds > 9 ? '$_seconds' : '0$_seconds';
    return '$hoursText:$minutesText:$secondsText';
  }

  void updateTime() {
    int newTotalSeconds = _currentTotalTime - 1;
    _hours = newTotalSeconds.convertToHoursFromSeconds();
    _minutes = newTotalSeconds.convertToMinutesFromSeconds();
    _seconds = newTotalSeconds.convertToSecondsFromSeconds();
    state = state.copyWith(
      timeText: _timeText,
    );
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
      (timer) => updateTime(),
    );
  }

  void _stopTimer() {
    _timer?.cancel();
    print('stop');
  }
}
