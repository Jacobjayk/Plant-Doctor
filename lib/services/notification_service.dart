import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tzdata.initializeTimeZones();
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings settings = InitializationSettings(android: androidSettings);
    await _notifications.initialize(settings);
  }

  static Future<void> scheduleWeeklyReminder() async {
    await _notifications.zonedSchedule(
      0,
      "Plant Disease Reminder",
      "Don't forget to check your plants for diseases!",
      _nextInstanceOfWeekday(hour: 9, minute: 0),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'plant_reminder_channel',
          'Plant Reminders',
          channelDescription: 'Weekly plant disease check reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      androidScheduleMode: AndroidScheduleMode.inexact, // Use inexact to avoid permission issues
    );
  }

  static Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }

  static tz.TZDateTime _nextInstanceOfWeekday({required int hour, required int minute}) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    // Schedule for next Monday if today has passed
    while (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
