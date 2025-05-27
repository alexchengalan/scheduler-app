import 'package:flutter/material.dart';

class DateTimePickerField extends StatelessWidget {
  final DateTime? dateTime;
  final String label;
  final IconData icon;
  final void Function(DateTime selectedDateTime) onDateTimeSelected;

  const DateTimePickerField({
    super.key,
    required this.dateTime,
    required this.label,
    required this.icon,
    required this.onDateTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(12));

    return InkWell(
      onTap: () async {
        final now = DateTime.now();

        final date = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: now,
          lastDate: DateTime(2100),
        );

        if (date != null && context.mounted) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(now),
          );

          if (time != null) {
            onDateTimeSelected(
              DateTime(date.year, date.month, date.day, time.hour, time.minute),
            );
          }
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: border,
        ),
        child: Text(
          dateTime != null ? '$dateTime'.split('.')[0] : 'Tap to select',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
