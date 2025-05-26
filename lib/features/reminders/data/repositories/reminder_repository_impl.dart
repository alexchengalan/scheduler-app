import 'package:scheduler/features/reminders/data/datasources/local_datasource.dart';
import 'package:scheduler/features/reminders/data/models/reminder_model.dart';
import 'package:scheduler/features/reminders/domain/entities/reminder_entity.dart';
import 'package:scheduler/features/reminders/domain/repositories/reminder_repository.dart';

class ReminderRepositoryImpl implements ReminderRepository {
  final LocalReminderDataSource localDataSource;

  ReminderRepositoryImpl(this.localDataSource);

  @override
  Future<void> addReminder(ReminderEntity entity) {
    final model = ReminderModel.fromEntity(entity);
    return localDataSource.add(model);
  }

  @override
  Future<void> updateReminder(ReminderEntity entity) {
    final model = ReminderModel.fromEntity(entity);
    return localDataSource.update(model);
  }

  @override
  Future<void> deleteReminder(String id) async {
    final model = localDataSource.getById(id);
    if (model != null) {
      await localDataSource.delete(model);
    } else {
      throw Exception("Reminder not found for deletion");
    }
  }

  @override
  Future<List<ReminderEntity>> getReminders() async {
    final models = await localDataSource.getAll();
    return models.map((m) => m.toEntity()).toList();
  }
}
