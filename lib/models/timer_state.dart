import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_state.freezed.dart';

@freezed
class TimerState with _$TimerState {
  const factory TimerState({
    required bool isActive,
  }) = _TimerState;
}

const TimerState kInitialTimerState = TimerState(isActive: false);
