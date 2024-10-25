class GetPlantsResponse {
  final String message;
  final List<Plant> plants;

  GetPlantsResponse({
    required this.message,
    required this.plants,
  });
  factory GetPlantsResponse.empty(String message) =>
      GetPlantsResponse(message: message, plants: []);
  factory GetPlantsResponse.fromJson(Map<String, dynamic> json) =>
      GetPlantsResponse(
        message: json["message"],
        plants: List<Plant>.from(json["plants"].map((x) => Plant.fromJson(x))),
      );
}

class Plant {
  final int id;
  final String name;
  final String daysToHarvest;
  final String wateringFreq;
  final String wateringAmount;
  final String fertilizer;
  final String fertilizationCycle;
  final String soil;
  final String temperature;
  final List<String> stepsToGrow;
  final String image;

  Plant({
    required this.id,
    required this.name,
    required this.daysToHarvest,
    required this.wateringFreq,
    required this.wateringAmount,
    required this.fertilizer,
    required this.fertilizationCycle,
    required this.soil,
    required this.temperature,
    required this.stepsToGrow,
    required this.image,
  });

  int getAvgHarvestDays() {
    RegExp regExp = RegExp(r'\d+');
    Iterable<Match> matches = regExp.allMatches(daysToHarvest);

    List<int> numbers =
        matches.map((match) => int.parse(match.group(0)!)).toList();

    int avg = (numbers.reduce((a, b) => a + b) / numbers.length).ceil();
    return avg;
  }

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
        id: json["id"],
        name: json["name"],
        daysToHarvest: json["days-to-harvest"],
        wateringFreq: json["watering freq"],
        wateringAmount: json["watering amount"],
        fertilizer: json["fertilizer"],
        fertilizationCycle: json["fertilization cycle"],
        soil: json["soil"],
        temperature: json["temperature"],
        stepsToGrow: List<String>.from(json["steps to grow"].map((x) => x)),
        image: json["image"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "days-to-harvest": daysToHarvest,
        "watering freq": wateringFreq,
        "watering amount": wateringAmount,
        "fertilizer": fertilizer,
        "fertilization cycle": fertilizationCycle,
        "soil": soil,
        "temperature": temperature,
        "steps to grow": List<dynamic>.from(stepsToGrow.map((x) => x)),
        "image": image,
      };
}
