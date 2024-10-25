import 'dart:async';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:plantiful/core/app_colors.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static StreamController<int> streamController = StreamController();

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    flutterLocalNotificationsPlugin.initialize(
      settings,
    );
  }

  showBasicNotification() async {
    NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails("0", "Watering",
            color: AppColors.primary,
            icon: "@mipmap/ic_launcher",
            importance: Importance.max,
            priority: Priority.max));

    await flutterLocalNotificationsPlugin.show(0, "Check your Mint",
        "If the soil is dry, make sure to water it", notificationDetails);
  }

  showWateringNotification({required String plantName, required int id}) async {
    log("from shownotification: $id");
    streamController.sink.add(id);
    NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails("2", "Watering",
            icon: "@mipmap/ic_launcher",
            importance: Importance.max,
            priority: Priority.max));

    await flutterLocalNotificationsPlugin.show(id, "Check your $plantName",
        "If the soil is dry, make sure to water it", notificationDetails,
        payload: "$id");
  }
}
