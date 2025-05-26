import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scheduler/features/reminders/presentation/notifier/reminder_form_notifier.dart';
import 'package:scheduler/features/reminders/presentation/notifier/reminder_form_state.dart';

final reminderFormProvider =
    StateNotifierProvider<ReminderFormNotifier, ReminderFormState>(
      (ref) => ReminderFormNotifier(),
    );
