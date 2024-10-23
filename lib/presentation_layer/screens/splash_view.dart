import 'dart:async';

import 'package:atlas_icons/atlas_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:plantiful/presentation_layer/screens/onboarding.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              maintainState: false,
              builder: (ctx) {
                return const Onboarding();
              }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              AppColors.accent,
              AppColors.secondary,
              AppColors.primary,
            ])),
        child: Center(
          child: Animate(
            effects: const [
              FlipEffect(),
              MoveEffect(duration: Duration(seconds: 1))
            ],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Atlas.green_battery,
                  size: 36,
                  color: AppColors.text,
                ),
                Text(
                  "Plantiful",
                  style: GoogleFonts.patrickHand(
                      textStyle: const TextStyle(
                          fontSize: FontSize.f48, color: AppColors.text)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
