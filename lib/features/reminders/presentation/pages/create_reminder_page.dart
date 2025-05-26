import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scheduler/core/widgets/page_header_bar.dart';
import 'package:scheduler/features/reminders/domain/entities/reminder_entity.dart';
import 'package:scheduler/features/reminders/presentation/providers/reminder_form_provider.dart';
import 'package:scheduler/features/reminders/presentation/providers/reminder_provider.dart';

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
                    initialValue: state.description,
                    decoration: InputDecoration(
                      labelText: "Description",
                      prefixIcon: const Icon(Icons.description),
                      border: border,
                    ),
                    onChanged: (val) => _onDescriptionChanged(ref, val),
                    maxLines: 2,
                  ),
                  spacing,
                  InkWell(
                    onTap: () => _selectDateTime(context, ref),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: "Date & Time",
                        prefixIcon: const Icon(Icons.calendar_today),
                        border: border,
                      ),
                      child: Text(
                        state.dateTime != null
                            ? '${state.dateTime}'.split('.')[0]
                            : 'Tap to select',
                      ),
                    ),
                  ),
                  spacing,
                  DropdownButtonFormField<String>(
                    value: state.frequency?.name,
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
                                child: Text(f),
                              ),
                            )
                            .toList(),
                    onChanged: (val) => _onFrequencyChanged(ref, val),
                  ),
                  spacing,
                  ElevatedButton.icon(
                    onPressed: () => _onSavePressed(context, ref),
                    label: const Text("Save"),
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

  // -------------------------
  // Callback Functions
  // -------------------------

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

  Future<void> _selectDateTime(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(reminderFormProvider.notifier);

    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null && context.mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        notifier.setDateTime(
          DateTime(date.year, date.month, date.day, time.hour, time.minute),
        );
      }
    }
  }

  Future<void> _onSavePressed(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(reminderFormProvider.notifier);
    final state = ref.read(reminderFormProvider);

    if (notifier.isValid()) {
      final reminder = ReminderEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: state.title.trim(),
        description: state.description.trim(),
        dateTime: state.dateTime!,
        frequency: state.frequency,
      );

      final reminderNotifier = ref.read(reminderNotifierProvider.notifier);
      final success = await reminderNotifier.addReminder(reminder);

      if (context.mounted) {
        if (success) {
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to save reminder.")),
          );
        }
      }
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all required fields.")),
      );
    }
  }
}
