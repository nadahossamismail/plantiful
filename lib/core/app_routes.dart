import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantiful/cubits/fertilizers/fertilizers_cubit.dart';
import 'package:plantiful/cubits/firebasefirestore/firestore_cubit.dart';
import 'package:plantiful/cubits/plants/plants_cubit.dart';
import 'package:plantiful/cubits/weather/weather_cubit.dart';
import 'package:plantiful/presentation_layer/screens/garden_view.dart';
import 'package:plantiful/presentation_layer/screens/location_view.dart';
import 'package:plantiful/presentation_layer/screens/login/login_view.dart';
import 'package:plantiful/presentation_layer/screens/onboarding_view.dart';
import 'package:plantiful/presentation_layer/screens/plants_view.dart';
import 'package:plantiful/presentation_layer/screens/sign_up/sign_up.dart';
import 'package:plantiful/presentation_layer/screens/splash_view.dart';

class Routes {
  static const String splashRoute = "/splash";
  static const String plantsRoute = "/plants";
  static const String gardenRoute = "/garden";
  static const String onboarding = "/onboarding";
  static const String loginRoute = "/login";
  static const String signUpRoute = "/signUp";
  static const String locationSettingRoute = "/location";
  static const String plantDetailsRoute = "/plantDetails";
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const Onboarding());
      case Routes.locationSettingRoute:
        return MaterialPageRoute(builder: (_) => const LocationSettingView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case Routes.plantsRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => PlantsCubit(),
                  child: const PlantsView(),
                ));
      case Routes.gardenRoute:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider(create: (context) => WeatherCubit()),
            BlocProvider(create: (context) => FertilizersCubit()),
            BlocProvider(create: (context) => FirestoreCubit()),
          ], child: const GardenView()),
        );

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
