import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scheduler/features/reminders/data/datasources/local_datasource.dart';
import 'package:scheduler/features/reminders/data/models/reminder_model.dart';
import 'package:scheduler/features/reminders/data/repositories/reminder_repository_impl.dart';
import 'package:scheduler/features/reminders/domain/entities/reminder_entity.dart';
import 'package:scheduler/features/reminders/domain/repositories/reminder_repository.dart';
import 'package:scheduler/features/reminders/presentation/notifier/reminder_notifier.dart';

final hiveBoxProvider = Provider<Box<ReminderModel>>(
  (ref) => Hive.box<ReminderModel>('reminders'),
);

final localDataSourceProvider = Provider<LocalReminderDataSource>(
  (ref) => LocalReminderDataSource(ref.read(hiveBoxProvider)),
);

final reminderRepositoryProvider = Provider<ReminderRepository>(
  (ref) => ReminderRepositoryImpl(ref.read(localDataSourceProvider)),
);

final reminderNotifierProvider =
    StateNotifierProvider<ReminderNotifier, List<ReminderEntity>>(
      (ref) => ReminderNotifier(ref.read(reminderRepositoryProvider)),
    );
