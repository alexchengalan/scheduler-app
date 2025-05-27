import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermissions {
  static Future<bool> requestPermissions(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  ) async {
    bool granted = true;

    if (Platform.isAndroid) {
      // Android 13+ (runtime notification permission)
      final status = await Permission.notification.request();
      granted = status.isGranted;
    }

    if (Platform.isIOS) {
      // iOS: Explicitly request alert, badge, and sound
      granted =
          await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin
              >()
              ?.requestPermissions(alert: true, badge: true, sound: true) ??
          false;
    }

    return granted;
  }
}
