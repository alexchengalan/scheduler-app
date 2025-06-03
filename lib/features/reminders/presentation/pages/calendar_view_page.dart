import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scheduler/core/utils/calendar_event_mapper.dart';
import 'package:scheduler/features/reminders/domain/entities/reminder_entity.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:scheduler/core/widgets/today_button.dart';
import 'package:scheduler/features/reminders/presentation/providers/reminder_provider.dart';
import 'package:scheduler/features/reminders/presentation/widgets/reminder_list_view.dart';

class RemindersCalendarPage extends ConsumerStatefulWidget {
  const RemindersCalendarPage({super.key});

  @override
  ConsumerState<RemindersCalendarPage> createState() =>
      _RemindersCalendarPageState();
}

class _RemindersCalendarPageState extends ConsumerState<RemindersCalendarPage> {
  late Map<DateTime, List<ReminderEntity>> _events;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    final reminders = ref.read(reminderNotifierProvider);
    _events = groupRemindersByDate(reminders);
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    final reminders = ref.watch(reminderNotifierProvider);
    _events = groupRemindersByDate(reminders);

    final selectedReminders = getRemindersForDay(_selectedDay!, _events);

    return Column(
      children: [
        // const PageHeaderBar(title: 'Calendar'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TodayButton(
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime.now();
                    _selectedDay = DateTime.now();
                  });
                },
              ),
            ],
          ),
        ),
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          eventLoader:
              (day) => _events[DateTime(day.year, day.month, day.day)] ?? [],
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          calendarStyle: CalendarStyle(
            // markerDecoration: const BoxDecoration(
            //   color: Colors.blueAccent,
            //   shape: BoxShape.circle,
            // ),
            todayDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              if (events.isEmpty) return const SizedBox.shrink();
              return Positioned(
                bottom: 12,
                child: Container(
                  width: 24,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 16),
        Expanded(child: ReminderListView(reminders: selectedReminders)),
      ],
    );
  }
}
