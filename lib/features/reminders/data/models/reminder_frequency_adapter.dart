import 'package:hive/hive.dart';
import 'package:scheduler/features/reminders/domain/entities/reminder_entity.dart';

class ReminderFrequencyAdapter extends TypeAdapter<ReminderFrequency> {
  @override
  final int typeId = 1;

  @override
  ReminderFrequency read(BinaryReader reader) {
    return ReminderFrequency.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, ReminderFrequency obj) {
    writer.writeInt(obj.index);
  }
}