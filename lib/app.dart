import 'package:flutter/material.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_routes.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:plantiful/presentation_layer/screens/garden_view.dart';
import 'package:plantiful/presentation_layer/screens/location.dart';
import 'package:plantiful/presentation_layer/screens/onboarding.dart';
import 'package:plantiful/presentation_layer/screens/sign_up/sign_up.dart';
import 'package:plantiful/presentation_layer/screens/splash_view.dart';

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
        home: const Onboarding());
  }
}
