class ReminderEntity {
  final String id;
  final String title;
  final String? description;
  final String? imagePath;
  final DateTime dateTime;
  final ReminderFrequency? frequency;

  ReminderEntity({
    required this.id,
    required this.title,
    this.description,
    this.imagePath,
    required this.dateTime,
    this.frequency,
  });
}

enum ReminderFrequency { daily, weekly, monthly, yearly }
