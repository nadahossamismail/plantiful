import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_routes.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantiful/data_layer.dart/models/onboarding_content.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controller = PageController();
  final Duration duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          controller: controller,
          itemCount: pageContent.length,
          itemBuilder: (context, pageIndex) {
            return Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppSpacingSizing.s24,
                  vertical: AppSpacingSizing.s128),
              child: Column(
                children: [
                  SvgPicture.asset(
                    pageContent[pageIndex]["image"],
                    width: 180,
                    height: 180,
                  ),
                  const SizedBox(height: AppSpacingSizing.s32),
                  PageViewDotIndicator(
                      currentItem: pageIndex,
                      size: const Size(7, 7),
                      unselectedSize: const Size(7, 7),
                      count: pageContent.length,
                      unselectedColor: Colors.black26,
                      selectedColor: AppColors.primary),
                  const SizedBox(height: AppSpacingSizing.s8),
                  Text(
                    pageContent[pageIndex]["title"],
                    textAlign: TextAlign.left,
                    style: GoogleFonts.patrickHand(
                        textStyle: const TextStyle(
                      fontSize: 32,
                      color: AppColors.text,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                  const SizedBox(height: AppSpacingSizing.s4),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 1.2,
                    child: Text(
                      pageContent[pageIndex]["description"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: FontSize.f16),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () => pageIndex == pageContent.length - 1
                              ? controller.previousPage(
                                  duration: duration, curve: Curves.ease)
                              : controller.jumpToPage(pageContent.length - 1),
                          child: Text(
                            pageIndex == pageContent.length - 1
                                ? "Back"
                                : "Skip",
                            style: const TextStyle(
                                fontSize: FontSize.f16,
                                color: Color.fromARGB(255, 87, 86, 86)),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            pageIndex == pageContent.length - 1
                                ? Navigator.of(context)
                                    .pushReplacementNamed(Routes.signUpRoute)
                                : controller.nextPage(
                                    duration: duration, curve: Curves.ease);
                          },
                          child: pageIndex == pageContent.length - 1
                              ? const Text("Get Started")
                              : const Icon(Icons.arrow_forward))
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
