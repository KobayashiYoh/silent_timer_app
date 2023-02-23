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
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 240.0,
                height: 240.0,
                child: CircularProgressIndicator(
                  value: state.progressValue,
                  strokeWidth: 16.0,
                  backgroundColor: Colors.grey,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.timeText,
                    style: const TextStyle(fontSize: 32.0),
                  ),
                  SizedBox(
                    width: 160.0,
                    child: TextField(
                      onChanged: notifier.onChangedTextField,
                      onSubmitted: notifier.onSubmitted,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.edit_outlined),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: notifier.onPressedPlayButton,
        child: Text(state.isActive ? 'stop' : 'start'),
      ),
    );
  }
}
