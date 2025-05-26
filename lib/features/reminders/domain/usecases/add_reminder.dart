import 'package:scheduler/features/reminders/domain/entities/reminder_entity.dart';
import 'package:scheduler/features/reminders/domain/repositories/reminder_repository.dart';

class AddReminder {
  final ReminderRepository repository;
  AddReminder(this.repository);

  Future<void> call(ReminderEntity reminder) {
    return repository.addReminder(reminder);
  }
}
