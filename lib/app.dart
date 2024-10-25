import 'package:flutter/material.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_routes.dart';
import 'package:plantiful/presentation_layer/screens/location.dart';

class MyApp extends StatelessWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();
  factory MyApp() => _instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        )),
        home: const LocationSettingView());
  }
}
