import 'package:flutter/material.dart';
import 'package:scheduler/core/utils/gradient_color_picker.dart';
import 'package:scheduler/core/utils/icon_picker_service.dart';
import 'package:scheduler/core/widgets/icon_circle.dart';
import 'package:scheduler/core/widgets/no_data_widget.dart';
import 'package:scheduler/features/reminders/domain/entities/reminder_entity.dart';
import 'package:scheduler/features/reminders/presentation/widgets/reminder_detail_modal.dart';

class ReminderListView extends StatelessWidget {
  final List<ReminderEntity> reminders;

  const ReminderListView({super.key, required this.reminders});

  @override
  Widget build(BuildContext context) {
    final iconPicker = IconPickerService();

    if (reminders.isEmpty) {
      return const NoDataWidget(
        icon: Icons.notifications_none,
        message: "No reminders for selected date",
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: reminders.length,
      itemBuilder: (context, index) {
        final reminder = reminders[index];
        final gradientColors = GradientColorPicker.pickGradient(index);

        return InkWell(
          onTap:
              () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) => ReminderDetailModal(reminder: reminder),
              ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconCircle(
                    icon: iconPicker.pickIcon(reminder.title),
                    backgroundColor: const Color(0xFFf2f4f3),
                    iconColor: gradientColors[0],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reminder.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          reminder.description ?? '',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
