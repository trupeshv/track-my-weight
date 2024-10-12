import 'package:track_my_weight/models/notification_model.dart';

typedef Json = Map<String, dynamic>;

///Language
const String LANG_ENGLISH = "en";

///Fonts
const String FONT_FAMILY_ROBOTO = "Roboto";

/// General Text
const String TRACK_MY_WEIGHT = "Track My Weight";

/// Date formats
const String TIMESTAMP_FORMAT_DD_MM_YYYY = "MMM dd, yyyy";

List<NotificationModel> dailyNotificationList = [
  NotificationModel(
    id: 0,
    title: "Time to Weigh In!!",
    body: "It's time to record your weight. Stay on track!",
  ),
  NotificationModel(
    id: 0,
    title: "Daily Weight Reminder",
    body: "Don't forget to log your weight today for better tracking!",
  ),
  NotificationModel(
    id: 0,
    title: "Don't Forget Your Weight!",
    body: "Every bit of progress counts! Weigh yourself now.",
  ),
  NotificationModel(
    id: 0,
    title: "Record Your Weight Today!",
    body: "Remember to check your weight and keep up your healthy habits!",
  ),
];