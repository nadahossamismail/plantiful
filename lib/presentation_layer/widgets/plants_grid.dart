import 'package:flutter/material.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:plantiful/data_layer.dart/models/get_plants_response.dart';
import 'package:plantiful/presentation_layer/screens/plant_details.dart';
import 'package:transparent_image/transparent_image.dart';

class PlantsGrid extends StatelessWidget {
  final List<Plant> toBeDisplayedList;
  const PlantsGrid({super.key, required this.toBeDisplayedList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.only(
            // top: AppSpacingSizing.s8,
            left: AppSpacingSizing.s12,
            bottom: AppSpacingSizing.s12,
            right: AppSpacingSizing.s12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //  crossAxisSpacing: AppSpacingSizing.s4,
            mainAxisSpacing: AppSpacingSizing.s8,
            crossAxisCount: 2),
        itemCount: toBeDisplayedList.length,
        itemBuilder: (context, index) {
          return PlantItem(plant: toBeDisplayedList[index]);
        });
  }
}

class PlantItem extends StatelessWidget {
  final Plant plant;
  const PlantItem({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => PlantDetailsView(plant: plant))),
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: AppSpacingSizing.s12,
        margin: const EdgeInsets.only(
            left: AppSpacingSizing.s12,
            right: AppSpacingSizing.s12,
            top: AppSpacingSizing.s4,
            bottom: AppSpacingSizing.s4),
        child: Stack(children: [
          Hero(
            tag: plant.id,
            child: FadeInImage(
                height: 250,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(plant.image)),
          ),
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
                  height: 5,
                ),
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
