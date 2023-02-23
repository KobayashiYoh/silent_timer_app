import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silent_timer_app/providers/timer_notifier.dart';
import 'package:silent_timer_app/ui_components/timer_list_item.dart';

class TimerPage extends ConsumerWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(timerProvider);
    final notifier = ref.read(timerProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
          child: Column(
            children: [
              Stack(
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
              const SizedBox(height: 64.0),
              Expanded(
                child: ListView(
                  children: const [
                    TimerListItem(timeText: '00:15:00'),
                    TimerListItem(timeText: '01:30:00'),
                    TimerListItem(timeText: '00:03:00'),
                  ],
                ),
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
