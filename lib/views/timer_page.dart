import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silent_timer_app/providers/timer_notifier.dart';

class TimerPage extends ConsumerWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(timerProvider);
    final notifier = ref.read(timerProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.timeText,
                style: const TextStyle(fontSize: 32.0),
              ),
              TextButton(
                onPressed: notifier.onPressedPlayButton,
                child: Text(state.isActive ? 'stop' : 'start'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
