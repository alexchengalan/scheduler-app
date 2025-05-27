import 'package:equatable/equatable.dart';
import 'package:scheduler/features/reminders/domain/entities/reminder_entity.dart';

class ReminderFormState extends Equatable {
  final String title;
  final String description;
  final DateTime? dateTime;
  final DateTime? remindAt;
  final ReminderFrequency? frequency;

  const ReminderFormState({
    this.title = '',
    this.description = '',
    this.dateTime,
    this.remindAt,
    this.frequency,
  });

  ReminderFormState copyWith({
    String? title,
    String? description,
    DateTime? dateTime,
    DateTime? remindAt,
    ReminderFrequency? frequency,
  }) {
    return ReminderFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      remindAt: remindAt ?? this.remindAt,
      frequency: frequency ?? this.frequency,
    );
  }

  @override
  List<Object?> get props => [
    title,
    description,
    dateTime,
    remindAt,
    frequency,
  ]; // ✅ Updated props
}
