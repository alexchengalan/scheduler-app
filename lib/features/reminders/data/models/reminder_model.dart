import 'package:hive/hive.dart';
import 'package:scheduler/features/reminders/domain/entities/reminder_entity.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 0)
class ReminderModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String? imagePath;

  @HiveField(4)
  final DateTime dateTime;

  @HiveField(5)
  final ReminderFrequency? frequency;

  @HiveField(6)
  final DateTime? remindAt;

  ReminderModel({
    required this.id,
    required this.title,
    this.description,
    this.imagePath,
    required this.dateTime,
    this.frequency,
    this.remindAt,
  });

  /// Convert from entity
  factory ReminderModel.fromEntity(ReminderEntity entity) {
    return ReminderModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      imagePath: entity.imagePath,
      dateTime: entity.dateTime,
      frequency: entity.frequency,
      remindAt: entity.remindAt,
    );
  }

  /// Convert to entity
  ReminderEntity toEntity() {
    return ReminderEntity(
      id: id,
      title: title,
      description: description,
      imagePath: imagePath,
      dateTime: dateTime,
      frequency: frequency,
      remindAt: remindAt,
    );
  }
}
