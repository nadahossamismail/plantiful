import 'dart:developer';
import 'package:atlas_icons/atlas_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_routes.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:plantiful/services/local_notification.dart';
import 'package:plantiful/services/work_manager.dart';
import 'package:plantiful/cubits/fertilizers/fertilizers_cubit.dart';
import 'package:plantiful/cubits/weather/weather_cubit.dart';
import 'package:plantiful/presentation_layer/screens/fertilizers_view.dart';
import 'package:plantiful/presentation_layer/widgets/garden_grid.dart';
import 'package:plantiful/presentation_layer/widgets/weather_detail.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class GardenView extends StatefulWidget {
  const GardenView({super.key});

  @override
  State<GardenView> createState() => _GardenViewState();
}

class _GardenViewState extends State<GardenView> {
  final _key = GlobalKey<ExpandableFabState>();
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
            Column(
              children: [
                BlocBuilder<WeatherCubit, WeatherState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: AppSpacingSizing.s24,
                              right: AppSpacingSizing.s24,
                              top: AppSpacingSizing.s24),
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
                                      log("set timer");
                                      WorkManagerService().cancleAll();
                                      LocalNotificationService()
                                          .showWateringNotification(
                                              id: 6, plantName: "Tomato");
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
                                ? Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        WeatherDetail(
                                          label: "Temp",
                                          value:
                                              "${state.weather.tempMax!.celsius!.ceil()}\u2103",
                                        ),
                                        WeatherDetail(
                                          label: "Humidity",
                                          value:
                                              "${state.weather.humidity!.ceil()}%",
                                        ),
                                        WeatherDetail(
                                          label: "feels like",
                                          value:
                                              "${state.weather.tempFeelsLike!.celsius!.ceil()}\u2103",
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                      ],
                    );
                  },
                ),
              ],
            ),
            const GardinGrid()
          ],
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
          closeButtonBuilder: RotateFloatingActionButtonBuilder(
            backgroundColor: AppColors.primary,
            child: const Icon(
              Icons.close,
            ),
            fabSize: ExpandableFabSize.small,
          ),
          openButtonBuilder: RotateFloatingActionButtonBuilder(
            backgroundColor: AppColors.primary,
            child: const Icon(
              Atlas.leaf,
            ),
            fabSize: ExpandableFabSize.regular,
          ),
          key: _key,
          type: ExpandableFabType.up,
          childrenAnimation: ExpandableFabAnimation.rotate,
          distance: 50,
          overlayStyle: const ExpandableFabOverlayStyle(),
          children: [
            FloatingActionButton.small(
              backgroundColor: AppColors.primary,
              heroTag: null,
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.plantsRoute),
              child: const Icon(
                Icons.add,
              ),
            ),
            FloatingActionButton.small(
              backgroundColor: AppColors.primary,
              heroTag: null,
              onPressed: () {
                showModalBottomSheet(
                    useSafeArea: true,
                    showDragHandle: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (_) {
                      return DraggableScrollableSheet(
                          expand: false,
                          builder: (context, controller) {
                            return BlocProvider(
                              create: (context) => FertilizersCubit(),
                              child: FertilizersScreen(
                                scrollController: controller,
                              ),
                            );
                          });
                    });
              },
              child: const Icon(
                Atlas.green_gas,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
