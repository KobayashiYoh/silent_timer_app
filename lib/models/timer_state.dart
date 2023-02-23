import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_state.freezed.dart';

@freezed
class TimerState with _$TimerState {
  const factory TimerState({
    required bool isActive,
    required String timeText,
    required double progressValue,
  }) = _TimerState;
}

const TimerState kInitialTimerState = TimerState(
  isActive: false,
  timeText: '00:00:00',
  progressValue: 0.0,
);
