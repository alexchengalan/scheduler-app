import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scheduler/features/reminders/domain/entities/reminder_entity.dart';
import 'package:scheduler/features/reminders/domain/repositories/reminder_repository.dart';

class ReminderNotifier extends StateNotifier<List<ReminderEntity>> {
  final ReminderRepository repository;
  ReminderNotifier(this.repository) : super([]) {
    load();
  }

  Future<void> load() async {
    state = await repository.getReminders();
  }

  /// Adds a reminder and returns true if successful, false otherwise.
  Future<bool> addReminder(ReminderEntity reminder) async {
    try {
      await repository.addReminder(reminder);
      await load(); // Reload updated list
      return true;
    } catch (e) {
      debugPrint('Error adding reminder: $e');
      return false;
    }
  }

  Future<bool> deleteReminder(String id) async {
    try {
      await repository.deleteReminder(id);
      await load(); // Reload updated list
      return true;
    } catch (e) {
      debugPrint('Error deleting reminder: $e');
      return false;
    }
  }
}