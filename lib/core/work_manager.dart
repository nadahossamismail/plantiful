import 'dart:developer';

import 'package:plantiful/core/local_notification.dart';
import 'package:plantiful/data_layer.dart/models/garden_plants.dart';

import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  Future<void> init() async {
    Workmanager().initialize(isInDebugMode: true, callTask);
  }

  registerTask({required GradenPlant gardenPlant}) async {
    log("from register");
    await Workmanager().registerPeriodicTask(
        gardenPlant.plant.id.toString(), gardenPlant.plant.name,
        frequency: const Duration(minutes: 15),
        inputData: {
          "plant": gardenPlant.plant.name,
          "id": gardenPlant.plant.id
        });
  }

  void cancleAll() async {
    log("cancle all");
    await Workmanager().cancelAll();
  }

  void cancleNotification({required GradenPlant gardenPlant}) async {
    log("cancled");
    await Workmanager().cancelByUniqueName(gardenPlant.plant.id.toString());
  }
}

@pragma('vm:entry-point')
callTask() {
  Workmanager().executeTask((task, inputData) async {
    log("task completed + $task");
    LocalNotificationService().showWateringNotification(
        plantName: inputData!["plant"], id: inputData["id"]);
    return Future.value(true);
  });
}
