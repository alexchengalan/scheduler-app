import 'package:scheduler/features/reminders/domain/entities/reminder_entity.dart';

Map<DateTime, List<ReminderEntity>> groupRemindersByDate(
  List<ReminderEntity> reminders,
) {
  final Map<DateTime, List<ReminderEntity>> events = {};

  for (var reminder in reminders) {
    final eventDate = DateTime(
      reminder.dateTime.year,
      reminder.dateTime.month,
      reminder.dateTime.day,
    );

    if (events[eventDate] != null) {
      events[eventDate]!.add(reminder);
    } else {
      events[eventDate] = [reminder];
    }
  }

  return events;
}

List<ReminderEntity> getRemindersForDay(
  DateTime day,
  Map<DateTime, List<ReminderEntity>> events,
) {
  final normalized = DateTime(day.year, day.month, day.day);
  return events[normalized] ?? [];
}
