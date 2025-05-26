import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scheduler/features/reminders/domain/entities/reminder_entity.dart';
import 'package:scheduler/features/reminders/presentation/notifier/reminder_form_state.dart';

class ReminderFormNotifier extends StateNotifier<ReminderFormState> {
  ReminderFormNotifier() : super(const ReminderFormState());

  void setTitle(String title) => state = state.copyWith(title: title);
  void setDescription(String description) =>
      state = state.copyWith(description: description);
  void setDateTime(DateTime dateTime) =>
      state = state.copyWith(dateTime: dateTime);
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
    state = ReminderFormState(); // Reset to default initial state
  }
}
