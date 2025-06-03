import 'package:flutter/material.dart';

class TodayButton extends StatelessWidget {
  final VoidCallback onPressed;

  const TodayButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.today),
      label: const Text('Today'),
    );
  }
}
