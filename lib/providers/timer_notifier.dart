import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silent_timer_app/extensions/int_extension.dart';
import 'package:silent_timer_app/main.dart';
import 'package:silent_timer_app/models/timer_state.dart';
import 'package:vibration/vibration.dart';

final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  return TimerNotifier();
});

class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier() : super(kInitialTimerState) {
    _initialTotalSeconds = _currentTotalSeconds;
  }
  late int _initialTotalSeconds;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 10;
  Timer? _timer;

  int get _currentTotalSeconds => _hours * 3600 + _minutes * 60 + _seconds;
  String get _timeText {
    String hoursText = _hours > 9 ? '$_hours' : '0$_hours';
    String minutesText = _minutes > 9 ? '$_minutes' : '0$_minutes';
    String secondsText = _seconds > 9 ? '$_seconds' : '0$_seconds';
    return '$hoursText:$minutesText:$secondsText';
  }

  void onChangedTextField(String inputText) {
    if (int.tryParse(inputText) == null || inputText.length > 6) {
      state = state.copyWith(
        timeText: _timeText,
      );
      return;
    }
  }

  void onSubmitted(String inputText) {
    if (int.tryParse(inputText) == null || inputText.length > 6) {
      return;
    }
    final String sixDigitString =
        inputText.length < 6 ? inputText.padLeft(6, '0') : inputText;
    _hours = int.parse(sixDigitString.substring(0, 2));
    _minutes = int.parse(sixDigitString.substring(2, 4));
    _seconds = int.parse(sixDigitString.substring(4, 6));
    state = state.copyWith(
      timeText: _timeText,
    );
    _initialTotalSeconds = _currentTotalSeconds;
  }

  void onPressedPlayButton() {
    state.isActive ? _stopTimer() : _startTimer();
    state = state.copyWith(
      isActive: !state.isActive,
    );
  }

  void setNotification() async {
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      // sound: 'example.mp3',
      presentAlert: true,
      presentBadge: true,
      presentSound: false,
    );
    NotificationDetails platformChannelSpecifics =
        const NotificationDetails(iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'むおーん', '時間になりました', platformChannelSpecifics);
  }

  void _finishTimer() {
    setNotification();
    Vibration.vibrate(
      pattern: [0, 1000, 500, 1000, 500, 1000],
      intensities: [0, 255, 0, 255, 0, 255],
    );
    _stopTimer();
    state = state.copyWith(
      timeText: '終了',
    );
  }

  void updateTime() {
    final int newTotalSeconds = _currentTotalSeconds - 1;
    _hours = newTotalSeconds.convertToHoursFromSeconds();
    _minutes = newTotalSeconds.convertToMinutesFromSeconds();
    _seconds = newTotalSeconds.convertToSecondsFromSeconds();
    state = state.copyWith(
      timeText: _timeText,
      progressValue: _currentTotalSeconds / _initialTotalSeconds,
    );
    if (_currentTotalSeconds <= 0) {
      _finishTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => updateTime(),
    );
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
