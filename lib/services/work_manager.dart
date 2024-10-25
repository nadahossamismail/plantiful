import 'dart:developer';

import 'package:plantiful/data_layer.dart/models/get_plants_response.dart';

import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  Future<void> init() async {}

  registerTask({required Plant gardenPlant}) async {
    log("from registerTask ${gardenPlant.id}");
    await Workmanager().registerPeriodicTask(
        "${gardenPlant.id}", gardenPlant.name,
        frequency: const Duration(minutes: 15),
        initialDelay: const Duration(minutes: 15),
        inputData: {"plant": gardenPlant.name, "id": gardenPlant.id});
  }

  void cancleAll() async {
    log("cancle all");
    await Workmanager().cancelAll();
  }

  void cancleNotification({required Plant gardenPlant}) async {
    log("cancled");
    await Workmanager().cancelByUniqueName(gardenPlant.id.toString());
  }
}
