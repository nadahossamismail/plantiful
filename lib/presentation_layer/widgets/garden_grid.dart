import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:plantiful/services/work_manager.dart';
import 'package:plantiful/cubits/firebasefirestore/firestore_cubit.dart';
import 'package:plantiful/data_layer.dart/models/get_plants_response.dart';
import 'package:plantiful/presentation_layer/widgets/empty_list.dart';
import 'package:plantiful/presentation_layer/widgets/something_went_wrong.dart';
import 'package:transparent_image/transparent_image.dart';

class GardinGrid extends StatefulWidget {
  const GardinGrid({super.key});

  @override
  State<GardinGrid> createState() => _GardinGridState();
}

class _GardinGridState extends State<GardinGrid> {
  @override
  void initState() {
    FirestoreCubit.get(context).getAllPlants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirestoreCubit, FirestoreState>(
      builder: (context, state) {
        return state is GetplantsLoading
            ? Expanded(
                child: LoadingAnimationWidget.waveDots(
                    color: AppColors.primary, size: 35),
              )
            : state is GetPlantsSuccess
                ? state.gardenPlants.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 200),
                        child: EmptyList(text: "let's add some plants"),
                      )
                    : Expanded(
                        child: GridView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacingSizing.s12),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: state.gardenPlants.length,
                            itemBuilder: (context, index) {
                              return GardenGridItem(
                                  gradenPlant: state.gardenPlants[index]);
                            }),
                      )
                : SomethingWentWrong(onPressed: () {
                    FirestoreCubit.get(context).getAllPlants();
                  });
      },
    );
  }
}

class GardenGridItem extends StatefulWidget {
  final Plant gradenPlant;
  const GardenGridItem({super.key, required this.gradenPlant});

  @override
  State<GardenGridItem> createState() => _GardenGridItemState();
}

class _GardenGridItemState extends State<GardenGridItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var plant = widget.gradenPlant;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) {
            var sTime = DateTime(2024, 10, 20);
            DateFormat formater = DateFormat('dd / MM / yyyy');
            var formatedDate = formater.format(sTime);
            var diff = DateTime.now().difference(sTime).inDays;
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CircularPercentIndicator(
                      radius: 45,
                      lineWidth: 8,
                      animation: true,
                      progressColor: AppColors.primary,
                      center: Text("$diff of ${plant.getAvgHarvestDays()}"),
                      percent: (diff / 60),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      plant.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Row(children: [Text(plant.wateringAmount)]),
                    Text("Planted on: $formatedDate"),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSpacingSizing.s16),
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll(AppColors.text),
                              backgroundColor:
                                  MaterialStatePropertyAll(AppColors.primary)),
                          onPressed: () {
                            Navigator.pop(context);
                            FirestoreCubit.get(context)
                                .removePlant(plant: plant);
                            WorkManagerService()
                                .cancleNotification(gardenPlant: plant);
                            FirestoreCubit.get(context).getAllPlants();
                          },
                          child: const Text("Harvest")),
                    ),
                  ]),
            );
          },
        );
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: AppSpacingSizing.s4,
        margin: const EdgeInsets.only(
            left: AppSpacingSizing.s12,
            right: AppSpacingSizing.s12,
            top: AppSpacingSizing.s16,
            bottom: AppSpacingSizing.s4),
        child: Stack(children: [
          FadeInImage(
              height: 250,
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(plant.image)),
          // plant.id == 1
          //     ? Positioned(
          //         right: 0,
          //         child: CircleAvatar(
          //           radius: AppSpacingSizing.s16,
          //           backgroundColor: Colors.black.withOpacity(0.5),
          //           child: const Icon(
          //             Icons.water_drop,
          //             color: Color.fromARGB(255, 142, 179, 241),
          //           ),
          //         ))
          //     : const SizedBox(),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                  top: AppSpacingSizing.s8, bottom: AppSpacingSizing.s8),
              color: Colors.black.withOpacity(0.5),
              child: Column(children: [
                Text(
                  plant.name,
                  style: const TextStyle(
                      fontSize: AppSpacingSizing.s16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: AppSpacingSizing.s4,
                ),
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
