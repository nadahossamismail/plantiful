import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_routes.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantiful/core/app_strings.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controller = PageController();
  final List pageContent = [
    {
      "image": AppImages.welcome,
      "title": "Welcome to plantiful!",
      "description": "Bring nature into your home",
    },
    {
      "image": AppImages.meantalHealth,
      "title": "Charge Your Mental Battery",
      "description":
          "Studies show that interacting with greenery reduces stress, enhances focus, and elevates mood by promoting relaxation.",
    },
    {
      "image": AppImages.gardening,
      "title": "Care Made Easy",
      "description":
          "Taking care of plants has never been simpler!, you’ll receive customized care reminders based on the specific needs of each plant in your collection.",
    },
    {
      "image": AppImages.notification,
      "title": "Notifications",
      "description":
          "Your perfect zone to get a crowd free, soothing shopping experience.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          itemCount: pageContent.length,
          itemBuilder: (context, pageIndex) {
            return Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: AppSpacingSizing.s12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    pageContent[pageIndex]["image"],
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: AppSpacingSizing.s48),
                  PageViewDotIndicator(
                      currentItem: pageIndex,
                      size: const Size(10, 10),
                      unselectedSize: const Size(10, 10),
                      count: pageContent.length,
                      unselectedColor: Colors.black26,
                      selectedColor: AppColors.primary),
                  const SizedBox(height: 25),
                  Text(
                    pageContent[pageIndex]["title"],
                    style: GoogleFonts.patrickHand(
                        textStyle: const TextStyle(
                            fontSize: FontSize.f24,
                            color: AppColors.text,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none)),
                  ),
                  const SizedBox(height: AppSpacingSizing.s4),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 1.2,
                    child: Text(
                      pageContent[pageIndex]["description"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: FontSize.f14),
                    ),
                  ),
                  const SizedBox(
                    height: AppSpacingSizing.s24,
                  ),
                  pageIndex == pageContent.length - 1
                      ? Padding(
                          padding: const EdgeInsets.all(AppSpacingSizing.s16),
                          child: MaterialButton(
                            padding: const EdgeInsets.all(AppSpacingSizing.s16),
                            color: AppColors.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    AppSpacingSizing.s12)),
                            onPressed: () => Navigator.of(context)
                                .pushReplacementNamed(Routes.signUpRoute),
                            child: const Text(
                              "Let's go",
                              style: TextStyle(
                                  fontSize: FontSize.f20,
                                  color: AppColors.text),
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            controller.jumpToPage(pageContent.length - 1);
                          },
                          child: const Text(
                            "SKIP",
                            style: TextStyle(
                                fontSize: FontSize.f16,
                                color: Color.fromARGB(255, 87, 86, 86)),
                          ))
                ],
              ),
            );
          },
          controller: controller,
        ),
      ),
    );
  }
}
