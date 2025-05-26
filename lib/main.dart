import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scheduler/app/router.dart';
import 'package:scheduler/core/theme/app_theme.dart';
import 'package:scheduler/features/reminders/data/models/reminder_frequency_adapter.dart';
import 'package:scheduler/features/reminders/data/models/reminder_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ReminderModelAdapter());
  Hive.registerAdapter(ReminderFrequencyAdapter());

  await Hive.openBox<ReminderModel>('reminders');
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
    );
  }
}
