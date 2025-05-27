import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scheduler/features/reminders/domain/entities/reminder_entity.dart';
import 'package:scheduler/features/reminders/domain/repositories/reminder_repository.dart';
import 'package:scheduler/core/services/notification_service.dart';

class ReminderNotifier extends StateNotifier<List<ReminderEntity>> {
  final ReminderRepository repository;
  final NotificationService notificationService;

  ReminderNotifier(this.repository, this.notificationService) : super([]) {
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
      await notificationService.cancelNotification(
        id.hashCode,
      ); // Also cancel scheduled notification
      await load(); // Reload updated list
      return true;
    } catch (e) {
      debugPrint('Error deleting reminder: $e');
      return false;
    }
  }

  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
    required int id,
    ReminderFrequency? frequency,
  }) async {
    debugPrint('@scheduleNotification $title at $scheduledTime');
    await notificationService.scheduleNotification(
      id: id,
      title: title,
      body: body,
      dateTime: scheduledTime,
      frequency: frequency,
    );
  }
}
