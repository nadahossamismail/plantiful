import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:plantiful/data_layer.dart/models/get_plants_response.dart';
import 'package:plantiful/presentation_layer/screens/steps_to_grow.dart';
import 'package:plantiful/presentation_layer/widgets/plant_detail.dart';
import 'package:atlas_icons/atlas_icons.dart';

class PlantDetailsView extends StatelessWidget {
  const PlantDetailsView({super.key, required this.plant});
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: CustomScrollView(
    //     slivers: [
    //       SliverAppBar(
    //         expandedHeight: 500,
    //         pinned: true,
    //         backgroundColor: Colors.black.withOpacity(0.5),
    //         stretch: true,
    //         flexibleSpace: FlexibleSpaceBar(
    //           collapseMode: CollapseMode.pin,
    //           title: Text(
    //             plant.name,
    //             style: const TextStyle(color: Colors.white),
    //           ),
    //           background: Hero(
    //             tag: plant.id,
    //             child: SizedBox(
    //               width: double.infinity,
    //               height: MediaQuery.sizeOf(context).height / 3,
    //               child: Image.network(
    //                 plant.image,
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       SliverList(
    //           delegate: SliverChildListDelegate([
    //         PlantDetail(
    //             icon: Icons.water_drop,
    //             title: "Water",
    //             subtitle: plant.wateringAmount),
    //         PlantDetail(
    //             icon: Icons.opacity,
    //             title: "Water Frequency",
    //             subtitle: plant.wateringFreq),
    //         PlantDetail(
    //             icon: Atlas.wheat_harvest,
    //             title: "Days to harvest",
    //             subtitle: plant.daysToHarvest),
    //         PlantDetail(
    //             icon: Icons.landslide_rounded,
    //             title: "Soil type",
    //             subtitle: plant.soil),
    //         PlantDetail(
    //             icon: Atlas.green_gas,
    //             title: "Fertilization cycle",
    //             subtitle: plant.fertilizationCycle),
    //         PlantDetail(
    //             icon: Atlas.celcius,
    //             title: "Temperature",
    //             subtitle: plant.temperature),
    //         const SizedBox(
    //           height: 230,
    //         )
    //       ]))
    //     ],
    //   ),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    //   floatingActionButton: FloatingActionButton.extended(
    //       backgroundColor: AppColors.primary,
    //       extendedIconLabelSpacing: AppSpacingSizing.s12,
    //       extendedPadding: const EdgeInsets.symmetric(
    //           horizontal: AppSpacingSizing.s24, vertical: AppSpacingSizing.s12),
    //       icon: const Icon(
    //         Atlas.hand_holding_plant,
    //         size: AppSpacingSizing.s24,
    //       ),
    //       onPressed: () => Navigator.of(context).push(MaterialPageRoute(
    //           builder: (_) => StepsToGrowView(
    //                 plant: plant,
    //               ))),
    //       label: Text(
    //         "Grow ${plant.name.toLowerCase()}",
    //         style: const TextStyle(fontSize: FontSize.f20),
    //       )),
    // );
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
        Stack(children: [
          Hero(
            tag: plant.id,
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height / 3,
              child: Image.network(
                plant.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const BackButton(
            color: Colors.white,
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black38)),
          )
        ]),
        Expanded(
          child: ListView(
            children: [
              PlantDetail(
                  icon: Icons.water_drop,
                  title: "Water",
                  subtitle: plant.wateringAmount),
              PlantDetail(
                  icon: Icons.opacity,
                  title: "Water Frequency",
                  subtitle: plant.wateringFreq),
              PlantDetail(
                  icon: Atlas.wheat_harvest,
                  title: "Days to harvest",
                  subtitle: plant.daysToHarvest),
              PlantDetail(
                  icon: Icons.landslide_rounded,
                  title: "Soil type",
                  subtitle: plant.soil),
              PlantDetail(
                  icon: Atlas.celcius,
                  title: "Temperature",
                  subtitle: plant.temperature),
              // PlantDetail(
              //     icon: Atlas.green_gas,
              //     title: "Fertilization cycle",
              //     subtitle: plant.fertilizationCycle),
            ],
          ),
        )
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          extendedIconLabelSpacing: AppSpacingSizing.s12,
          extendedPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacingSizing.s24, vertical: AppSpacingSizing.s12),
          icon: const Icon(
            Atlas.hand_holding_plant,
            size: AppSpacingSizing.s24,
          ),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => StepsToGrowView(
                    plant: plant,
                  ))),
          label: Text(
            "Grow ${plant.name.toLowerCase()}",
            style: const TextStyle(fontSize: FontSize.f20),
          )),
    ));
  }
}
