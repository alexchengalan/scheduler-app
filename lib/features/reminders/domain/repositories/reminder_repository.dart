import 'package:scheduler/features/reminders/domain/entities/reminder_entity.dart';

abstract class ReminderRepository {
  Future<void> addReminder(ReminderEntity reminder);
  Future<void> updateReminder(ReminderEntity reminder);
  Future<void> deleteReminder(String id);
  Future<List<ReminderEntity>> getReminders();
}
