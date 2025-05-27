import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scheduler/core/widgets/date_time_picker_field.dart';
import 'package:scheduler/core/widgets/page_header_bar.dart';
import 'package:scheduler/features/reminders/presentation/providers/reminder_form_provider.dart';

class CreateReminderPage extends ConsumerWidget {
  const CreateReminderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reminderFormProvider);
    final spacing = const SizedBox(height: 20);
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(12));
    final frequencies = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

    return Scaffold(
      body: Column(
        children: [
          PageHeaderBar(
            title: "Create Reminder",
            onClose: () => _onClosePressed(context, ref),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    initialValue: state.title,
                    decoration: InputDecoration(
                      labelText: "Title",
                      prefixIcon: const Icon(Icons.title),
                      border: border,
                    ),
                    onChanged: (val) => _onTitleChanged(ref, val),
                  ),
                  spacing,
                  TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    initialValue: state.description,
                    decoration: InputDecoration(
                      labelText: "Description",
                      prefixIcon: const Icon(Icons.description),
                      border: border,
                    ),
                    onChanged: (val) => _onDescriptionChanged(ref, val),
                    minLines: 2,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                  spacing,
                  DateTimePickerField(
                    label: "Date & Time",
                    icon: Icons.calendar_today,
                    dateTime: state.dateTime,
                    onDateTimeSelected:
                        (val) => ref
                            .read(reminderFormProvider.notifier)
                            .setDateTime(val),
                  ),
                  spacing,
                  DateTimePickerField(
                    label: "Remind Me On",
                    icon: Icons.notifications,
                    dateTime: state.remindAt,
                    onDateTimeSelected:
                        (val) => ref
                            .read(reminderFormProvider.notifier)
                            .setRemindAt(val),
                  ),
                  spacing,
                  DropdownButtonFormField<String>(
                    value: state.frequency?.name.toLowerCase(),
                    decoration: InputDecoration(
                      labelText: "Frequency",
                      prefixIcon: const Icon(Icons.repeat),
                      border: border,
                    ),
                    items:
                        frequencies
                            .map(
                              (f) => DropdownMenuItem(
                                value: f.toLowerCase(),
                                child: Text(
                                  f,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (val) => _onFrequencyChanged(ref, val),
                  ),
                  spacing,
                  ElevatedButton.icon(
                    onPressed: () => _onSavePressed(context, ref),
                    label: const Text("Save Reminder"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onClosePressed(BuildContext context, WidgetRef ref) {
    ref.read(reminderFormProvider.notifier).reset();
    Navigator.pop(context);
  }

  void _onTitleChanged(WidgetRef ref, String val) {
    ref.read(reminderFormProvider.notifier).setTitle(val);
  }

  void _onDescriptionChanged(WidgetRef ref, String val) {
    ref.read(reminderFormProvider.notifier).setDescription(val);
  }

  void _onFrequencyChanged(WidgetRef ref, String? val) {
    if (val != null) {
      ref.read(reminderFormProvider.notifier).setFrequency(val);
    }
  }

  Future<void> _onSavePressed(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(reminderFormProvider.notifier);

    final success = await notifier.submit();

    if (context.mounted) {
      if (success) {
        notifier.reset();
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to save reminder(s).")),
        );
      }
    }
  }
}
