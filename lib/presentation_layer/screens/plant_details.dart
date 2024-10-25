import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:plantiful/cubits/firebasefirestore/firestore_cubit.dart';
import 'package:plantiful/data_layer.dart/models/get_plants_response.dart';
import 'package:plantiful/presentation_layer/screens/steps_to_grow_view.dart';
import 'package:plantiful/presentation_layer/widgets/plant_detail.dart';
import 'package:atlas_icons/atlas_icons.dart';

class PlantDetailsView extends StatelessWidget {
  const PlantDetailsView({super.key, required this.plant});
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              leading: const Stack(children: [
                BackButton(
                  color: Colors.white,
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.black38)),
                )
              ]),
              expandedHeight: 440,
              backgroundColor: Colors.grey.withOpacity(0.7),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(plant.name),
                background: Hero(
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
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
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
                  icon: Atlas.green_gas,
                  title: "Fertilization cycle",
                  subtitle: plant.fertilizationCycle),
              PlantDetail(
                  icon: Atlas.celcius,
                  title: "Temperature",
                  subtitle: plant.temperature),
              const SizedBox(
                height: 230,
              )
            ]))
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppColors.primary,
            extendedIconLabelSpacing: AppSpacingSizing.s12,
            extendedPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacingSizing.s24,
                vertical: AppSpacingSizing.s12),
            icon: const Icon(
              Atlas.hand_holding_seedling_bold,
              size: AppSpacingSizing.s24,
            ),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BlocProvider(
                      create: (context) => FirestoreCubit(),
                      child: StepsToGrowView(
                        plant: plant,
                      ),
                    ))),
            label: Text(
              plant.name,
              style: const TextStyle(fontSize: FontSize.f20),
            )),
      ),
    );
  }
}
