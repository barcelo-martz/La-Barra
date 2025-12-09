import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationService {
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // timezone initialization
    tzdata.initializeTimeZones();
    final String tzName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(tzName));

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );
  }

  Future<void> showImmediateNotification(int id, String title, String body) async {
    const android = AndroidNotificationDetails('default_channel', 'Default',
        channelDescription: 'General notifications', importance: Importance.max, priority: Priority.high);
    const ios = DarwinNotificationDetails();
    await _plugin.show(id, title, body, const NotificationDetails(android: android, iOS: ios));
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  Future<void> scheduleDailyNotification({int id = 0, String title = 'La Barra', String body = 'Descubre una nueva receta hoy', int hour = 9, int minute = 0}) async {
    final scheduledDate = _nextInstanceOfTime(hour, minute);
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails('daily_channel', 'Daily', channelDescription: 'Daily notifications'),
        iOS: DarwinNotificationDetails(),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id);
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  /// Schedule a challenge reminder (default 18:00)
  Future<void> scheduleChallengeReminder({int id = 10, String title = 'Reto', String body = 'Revisa tu reto de hoy', int hour = 18, int minute = 0}) async {
    final scheduledDate = _nextInstanceOfTime(hour, minute);
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails('challenge_channel', 'Challenges', channelDescription: 'Challenge reminders'),
        iOS: DarwinNotificationDetails(),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelChallengeReminder({int id = 10}) async {
    await _plugin.cancel(id);
  }
}
