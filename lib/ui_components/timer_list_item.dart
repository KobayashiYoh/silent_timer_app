import 'package:flutter/material.dart';

class TimerListItem extends StatelessWidget {
  const TimerListItem({Key? key, required this.timeText}) : super(key: key);
  final String timeText;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(timeText),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.edit_outlined),
      ),
    );
  }
}
