import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:plantiful/presentation_layer/widgets/Expandable_fab.dart';
import 'package:plantiful/services/work_manager.dart';
import 'package:plantiful/cubits/weather/weather_cubit.dart';
import 'package:plantiful/presentation_layer/widgets/garden_grid.dart';
import 'package:plantiful/presentation_layer/widgets/weather_detail.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class GardenView extends StatefulWidget {
  const GardenView({super.key});

  @override
  State<GardenView> createState() => _GardenViewState();
}

class _GardenViewState extends State<GardenView> {
  @override
  void initState() {
    WeatherCubit.get(context).getWeather();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Nada's garden",
                            style: GoogleFonts.patrickHand(
                                textStyle: const TextStyle(
                                    fontSize: FontSize.f36,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.5)),
                          ),
                          Row(
                            children: [
                              const WeatherDetail(
                                value:
                                    "http://openweathermap.org/img/wn/10d@2x.png",
                              ),
                              GestureDetector(
                                child: const CircleAvatar(
                                    backgroundColor: AppColors.primary,
                                    child: Icon(Icons.person)),
                                onTap: () {
                                  log("cancle all");
                                  WorkManagerService().cancleAll();
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    state is WeatherLoading
                        ? LoadingAnimationWidget.progressiveDots(
                            color: AppColors.primary, size: 25)
                        : state is WeatherSuccess
                            ? WeatherPannel(state: state)
                            : const SizedBox.shrink()
                  ],
                );
              },
            ),
            const GardinGrid()
          ],
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFAB(),
      ),
    );
  }
}
