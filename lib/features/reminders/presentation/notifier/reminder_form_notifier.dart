import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scheduler/features/reminders/domain/entities/reminder_entity.dart';
import 'package:scheduler/features/reminders/presentation/notifier/reminder_form_state.dart';
import 'package:scheduler/features/reminders/presentation/notifier/reminder_notifier.dart';

class ReminderFormNotifier extends StateNotifier<ReminderFormState> {
  final ReminderNotifier notifier;

  ReminderFormNotifier(this.notifier) : super(const ReminderFormState());

  void setTitle(String title) => state = state.copyWith(title: title);
  void setDescription(String description) =>
      state = state.copyWith(description: description);
  void setDateTime(DateTime dateTime) =>
      state = state.copyWith(dateTime: dateTime);
  void setRemindAt(DateTime remindAt) =>
      state = state.copyWith(remindAt: remindAt);
  void setFrequency(String freqStr) {
    final frequency = ReminderFrequency.values.firstWhere(
      (f) => f.name.toLowerCase() == freqStr.toLowerCase(),
      orElse: () => ReminderFrequency.daily,
    );
    state = state.copyWith(frequency: frequency);
  }

  bool isValid() {
    return state.title.trim().isNotEmpty && state.dateTime != null;
  }

  void reset() {
    state = const ReminderFormState();
  }

  ReminderEntity buildReminder() {
    return ReminderEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: state.title.trim(),
      description: state.description.trim(),
      dateTime: state.dateTime!,
      remindAt: state.remindAt,
      frequency: state.frequency,
    );
  }

  Future<bool> submit() async {
    if (!isValid()) return false;

    final reminder = buildReminder();
    final success = await notifier.addReminder(reminder);

    if (success && state.remindAt != null) {
      await notifier.scheduleNotification(
        id: reminder.id.hashCode,
        title: reminder.title,
        body: reminder.description ?? '',
        scheduledTime: state.remindAt!,
        frequency: state.frequency,
      );
    }

    return success;
  }
}
