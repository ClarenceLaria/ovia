import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class DailyNotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  final bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  //Initialize
  Future<void> initNotification() async {
    if (_isInitialized) return;

    //Prepare android
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    //Prepare IOS
    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    //init settings
    const initSettings = InitializationSettings(
      android: android,
      iOS: initSettingsIOS,
    );

    //initialize the plugin
    await _notifications.initialize(initSettings);

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    final String timeZoneName = tz.local.name; // Use system time zone
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await _notifications.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder',
          'Daily Reminder',
          channelDescription: 'Daily Reminder channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> scheduleDailyReminder({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    print("local time zone: ${tz.local}, current time: $now, ${tz.local.name}");

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    await _notifications.zonedSchedule(
      androidScheduleMode: AndroidScheduleMode
          .exactAllowWhileIdle, // Allows the notification to be shown even when the device is idle
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder',
          'Daily Reminder',
          channelDescription: 'Daily Reminder channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'daily_reminder_payload',
    );
    print(
        'Notification scheduled for: ${scheduledDate.hour}:${scheduledDate.minute}');
  }

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }
}
