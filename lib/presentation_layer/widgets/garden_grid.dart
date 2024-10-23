import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:plantiful/data_layer.dart/models/garden_plants.dart';
import 'package:plantiful/data_layer.dart/models/get_plants_response.dart';
import 'package:plantiful/presentation_layer/widgets/empty_list.dart';
import 'package:transparent_image/transparent_image.dart';

class GardinGrid extends StatelessWidget {
  const GardinGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return gardenPlants.isEmpty
        ? const Padding(
            padding: EdgeInsets.only(top: 200),
            child: EmptyList(text: "let's add some plants"),
          )
        : Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacingSizing.s12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: gardenPlants.length,
                itemBuilder: (context, index) {
                  return GardenGridItem(gradenPlant: gardenPlants[index]);
                }),
          );
  }
}

class GardenGridItem extends StatelessWidget {
  final GradenPlant gradenPlant;
  const GardenGridItem({super.key, required this.gradenPlant});

  @override
  Widget build(BuildContext context) {
    var plant = gradenPlant.plant;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) {
            var sTime = DateTime(2024, 10, 20);
            var diff = DateTime.now().difference(sTime).inDays;
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                CircularPercentIndicator(
                  radius: 45,
                  lineWidth: 8,
                  animation: true,
                  progressColor: AppColors.primary,
                  center: Text("$diff of 80"),
                  percent: (diff / 60),
                ),
                Text(plant.name),
                Text(plant.wateringAmount),
                Text("Planted at: ${gradenPlant.startDate}"),
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
          plant.id == 1
              ? Positioned(
                  right: 0,
                  child: CircleAvatar(
                    radius: AppSpacingSizing.s16,
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: const Icon(
                      Icons.water_drop,
                      color: Color.fromARGB(255, 142, 179, 241),
                    ),
                  ))
              : const SizedBox(),
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
