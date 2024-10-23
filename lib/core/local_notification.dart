import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:plantiful/core/app_colors.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: (details) {
        log("${details.payload!}id of ");
      },
      onDidReceiveNotificationResponse: (details) {
        log("${details.payload!}id of ");
      },
    );
  }

  showBasicNotification() async {
    NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails("0", "Watering",
            color: AppColors.primary,
            importance: Importance.max,
            priority: Priority.max));

    await flutterLocalNotificationsPlugin.show(0, "Check your Mint",
        "If the soil is dry, make sure to water it", notificationDetails);
  }

  showWateringNotification({required String plantName, required int id}) async {
    NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails("2", "Watering",
            showProgress: true,
            importance: Importance.max,
            priority: Priority.max));

    await flutterLocalNotificationsPlugin.show(
        id,
        "Check your $plantName",
        "You are doing good so far!\nIf the soil is dry, make sure to water it",
        notificationDetails,
        payload: id.toString());
  }
}
