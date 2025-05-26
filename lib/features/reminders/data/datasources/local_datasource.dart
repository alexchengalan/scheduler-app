
import 'package:hive/hive.dart';
import 'package:scheduler/features/reminders/data/models/reminder_model.dart';

class LocalReminderDataSource {
  final Box<ReminderModel> box;

  LocalReminderDataSource(this.box);

  Future<void> add(ReminderModel model) async {
    await box.put(model.id, model); // Still needed for first-time insert
  }

  Future<void> update(ReminderModel model) async {
    await model.save(); // Use HiveObject's save for updates
  }

  Future<void> delete(ReminderModel model) async {
    await model.delete(); // Use HiveObject's delete
  }

  Future<List<ReminderModel>> getAll() async {
    return box.values.toList();
  }

  ReminderModel? getById(String id) {
    return box.get(id);
  }
}