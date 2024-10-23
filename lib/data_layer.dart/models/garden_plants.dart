import 'package:plantiful/data_layer.dart/models/get_plants_response.dart';

List<GradenPlant> gardenPlants = [];

class GradenPlant {
  final Plant plant;
  final String startDate;

  GradenPlant({required this.plant, required this.startDate});
}
