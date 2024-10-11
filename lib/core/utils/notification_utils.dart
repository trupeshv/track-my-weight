import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:track_my_weight/core/constants/constants.dart';
import 'package:track_my_weight/core/utils/app_utils.dart';
import 'package:track_my_weight/models/notification_model.dart';

class NotificationUtils {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  DarwinNotificationDetails iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

  notificationDetails() {
    return NotificationDetails(
      android: const AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max, priority: Priority.high, icon: '@mipmap/ic_launcher'),
      iOS: iOSPlatformChannelSpecifics,
    );
  }

  Future<void> cancelNotification() async {
    await notificationsPlugin.cancelAll();
  }

  Future scheduleNotification({required DateTime scheduledNotificationDateTime}) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings();
    var initSettings = const InitializationSettings(
        android: initializationSettingsAndroid, iOS: darwinInitializationSettings);
    notificationsPlugin.initialize(initSettings);
    return notificationsPlugin.zonedSchedule(
      notification().id,
      notification().title,
      notification().body,
      _nextInstanceOfTenAM(scheduledNotificationDateTime),
      await notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}

tz.TZDateTime _nextInstanceOfTenAM(DateTime date) {
  final tz.TZDateTime now = tz.TZDateTime.from(
    date,
    tz.local,
  );
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, now.hour, now.minute);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

NotificationModel notification() {
  DateTime now = DateTime.now();
  return dailyNotificationList[now.dayOfYear % dailyNotificationList.length];
}
