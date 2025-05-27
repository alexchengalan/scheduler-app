import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:scheduler/features/reminders/domain/entities/reminder_entity.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

/// TOP-LEVEL HANDLER (Required for background notifications)
@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(NotificationResponse response) {
  // Minimal logic here (e.g., logging or queue navigation intent)
  // Navigation does not work here directly – use a background queue or shared prefs if needed
  debugPrint(
    "@onDidReceiveBackgroundNotificationResponse; payload: ${response.payload}",
  );
}

/// Foreground tap handler – can be used for navigation
void onNotificationResponse(NotificationResponse response) {
  // Handle when notification is tapped in foreground
  // For navigation: use a GlobalKey<NavigatorState> or service locator
  debugPrint("@onNotificationResponse; payload: ${response.payload}");
  // Example: NavigationService.navigatorKey.currentState?.pushNamed('/reminders');
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> init() async {
    tz_data.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: onNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
    required ReminderFrequency? frequency,
  }) async {
    final tz.TZDateTime tzDateTime = tz.TZDateTime.from(dateTime, tz.local);

    final notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        'reminder_channel',
        'Reminders',
        channelDescription: 'Notification channel for reminders',
        importance: Importance.max,
        priority: Priority.high,
        enableVibration: true,
        ticker: 'Reminder',
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzDateTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents:
          frequency != null
              ? _mapFrequencyToDateTimeComponents(frequency)
              : null,
    );
  }

  DateTimeComponents? _mapFrequencyToDateTimeComponents(
    ReminderFrequency freq,
  ) {
    switch (freq) {
      case ReminderFrequency.daily:
        return DateTimeComponents.time;
      case ReminderFrequency.weekly:
        return DateTimeComponents.dayOfWeekAndTime;
      case ReminderFrequency.monthly:
        return DateTimeComponents.dayOfMonthAndTime;
      case ReminderFrequency.yearly:
        return DateTimeComponents.dateAndTime;
    }
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
