import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantiful/core/app_routes.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:plantiful/core/app_strings.dart';
import 'package:plantiful/core/work_manager.dart';
import 'package:plantiful/cubits/firebasefirestore/firestore_cubit.dart';
import 'package:plantiful/data_layer.dart/models/get_plants_response.dart';
import 'package:plantiful/presentation_layer/widgets/snack_bar.dart';

class StepsToGrowView extends StatefulWidget {
  final Plant plant;

  const StepsToGrowView({super.key, required this.plant});

  @override
  State<StepsToGrowView> createState() => _StepsToGrowViewState();
}

class _StepsToGrowViewState extends State<StepsToGrowView> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.stepsToGrow,
            style: GoogleFonts.notoSans(
                textStyle: const TextStyle(fontSize: FontSize.f18)),
          ),
        ),
        floatingActionButton: currentStep == widget.plant.stepsToGrow.length - 1
            ? FloatingActionButton(
                child: const Text("Done"),
                onPressed: () {
                  FirestoreCubit.get(context).addPlant(plant: widget.plant);
                  AppSnackBar.showSnackBar(context,
                      "Congrats, you have planted ${widget.plant.name}");
                  WorkManagerService().registerTask(gardenPlant: widget.plant);
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.gardenRoute);
                })
            : null,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacingSizing.s12, vertical: 12),
              child: Stepper(
                controlsBuilder: (context, details) {
                  return Padding(
                    padding: const EdgeInsets.only(top: AppSpacingSizing.s12),
                    child: Row(
                      children: <Widget>[
                        currentStep != 5
                            ? ElevatedButton(
                                onPressed: details.onStepContinue,
                                child: const Text('NEXT'),
                              )
                            : const SizedBox(),
                        const SizedBox(width: 8),
                        currentStep != 0
                            ? TextButton(
                                onPressed: details.onStepCancel,
                                child: const Text('BACK'),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  );
                },
                onStepTapped: (value) => setState(() {
                  currentStep = value;
                }),
                currentStep: currentStep,
                onStepContinue: () => setState(() {
                  currentStep < 5 ? currentStep++ : null;
                }),
                onStepCancel: () => setState(() {
                  currentStep > 0 ? currentStep-- : null;
                }),
                steps: widget.plant.stepsToGrow
                    .map((step) => Step(
                        isActive: currentStep >=
                            widget.plant.stepsToGrow.indexOf(step),
                        title: Text(step.split(": ").first,
                            style: GoogleFonts.notoSans(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.f18))),
                        content: Text(step.split(": ").last,
                            style: GoogleFonts.notoSans(
                                textStyle:
                                    const TextStyle(fontSize: FontSize.f16)))))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
