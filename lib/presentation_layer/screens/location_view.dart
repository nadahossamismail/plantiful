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
import 'package:plantiful/services/location_service.dart';

class LocationSettingView extends StatefulWidget {
  const LocationSettingView({super.key});

  @override
  State<LocationSettingView> createState() => _LocationSettingViewState();
}

class _LocationSettingViewState extends State<LocationSettingView> {
  @override
  void initState() {
    LocationService.getLocationPermission(context);
    super.initState();
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
                style: GoogleFonts.patrickHand(
                    textStyle: const TextStyle(
                        fontSize: FontSize.f24, fontWeight: FontWeight.w800)),
              ),
              const SizedBox(
                width: 240,
                child: Text(
                  "We will save your geographic location to be able to fetch weather data.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: FontSize.f16),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: AppSpacingSizing.s24),
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
                          preferences.setDouble(
                              AppStrings.latKey, snapshot.data!.latitude);
                          preferences.setDouble(
                              AppStrings.lonKey, snapshot.data!.longitude);

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
