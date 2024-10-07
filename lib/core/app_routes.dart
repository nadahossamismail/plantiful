import 'package:flutter/material.dart';
import 'package:plantiful/presentation_layer/screens/garden_view.dart';
import 'package:plantiful/presentation_layer/screens/plants_view.dart';
import 'package:plantiful/presentation_layer/screens/splash_view.dart';

class Routes {
  static const String splashRoute = "/splash";
  static const String plantsRoute = "/plants";
  static const String gardenRoute = "/garden";
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.plantsRoute:
        return MaterialPageRoute(builder: (_) => const PlantsView());
      case Routes.gardenRoute:
        return MaterialPageRoute(builder: (_) => const GardenView());

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              body: Center(child: Text("Not Found")),
            ));
  }
}
