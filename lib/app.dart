import 'package:flutter/material.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_routes.dart';
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
        theme: AppTheme.theme,
        home: const SplashView());
  }
}
