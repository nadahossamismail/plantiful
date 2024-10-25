import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_routes.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:plantiful/core/app_strings.dart';
import 'package:plantiful/main.dart';
import 'package:plantiful/presentation_layer/widgets/alert_dialog.dart';

class LocationSettingView extends StatefulWidget {
  const LocationSettingView({super.key});

  @override
  State<LocationSettingView> createState() => _LocationSettingViewState();
}

class _LocationSettingViewState extends State<LocationSettingView> {
  @override
  void initState() {
    getLocation();
    super.initState();
  }

  void getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("service disabled")));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("if you don't allow acces we can't fetch weather data!")));
        permission = await Geolocator.requestPermission();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: double.infinity,
                  child: SvgPicture.asset(
                    AppImages.location,
                    width: 200,
                    height: 200,
                  )),
              const SizedBox(
                height: AppSpacingSizing.s16,
              ),
              Text(
                "Setting your garden location!",
                style: GoogleFonts.notoSans(
                    textStyle: const TextStyle(
                        fontSize: FontSize.f24, fontWeight: FontWeight.w700)),
              ),
              Text(
                "We are going to save your geographic location in order to get weather data.",
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSans(
                    textStyle: const TextStyle(fontSize: FontSize.f14)),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: AppSpacingSizing.s16),
                padding:
                    const EdgeInsets.symmetric(vertical: AppSpacingSizing.s8),
                child: FutureBuilder(
                  future: Geolocator.getCurrentPosition(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingAnimationWidget.beat(
                          color: AppColors.primary, size: 25);
                    } else if (snapshot.hasError) {
                      return TextButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: const Text("Try again"));
                    } else if (snapshot.hasData) {
                      return ElevatedButton(
                        child: const Text(
                          "Continue",
                          style: TextStyle(),
                        ),
                        onPressed: () {
                          preferences.setDouble("lat", snapshot.data!.latitude);
                          preferences.setDouble(
                              "lon", snapshot.data!.longitude);
                          log("saved lon:${snapshot.data!.longitude}");
                          Navigator.pushReplacementNamed(
                              context, Routes.gardenRoute);
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
