import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plantiful/app.dart';
import 'package:plantiful/core/bloc_observer.dart';
import 'package:plantiful/core/local_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

late SharedPreferences preferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  LocalNotificationService.init();
  Workmanager().initialize(isInDebugMode: true, callTask);
  Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAKfMNMLoz0Qoe8uy0-Tx6BmhsVvGHfikI',
    appId: '1:284706998055:android:d0c2a5d85f3d189f068b02',
    messagingSenderId: 'sendid',
    projectId: 'plantiful-15407',
    storageBucket: 'plantiful-15407.appspot.com',
  ));
  // FirebaseFirestore.instance.settings =
  //     const Settings(persistenceEnabled: true);

  preferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

@pragma('vm:entry-point')
callTask() {
  Workmanager().executeTask((task, inputData) async {
    log("from execute task + ${inputData!["plant"]},${inputData["id"]}");
    LocalNotificationService().showWateringNotification(
        plantName: inputData["plant"], id: inputData["id"]);
    return Future.value(true);
  });
}
