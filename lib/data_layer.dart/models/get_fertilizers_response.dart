import 'dart:convert';

GetFertilizerResponse getFertilizerResponseFromJson(String str) =>
    GetFertilizerResponse.fromJson(json.decode(str));

class GetFertilizerResponse {
  final String message;
  final List<Fertilizer> fertilizers;

  GetFertilizerResponse({
    required this.message,
    required this.fertilizers,
  });
  factory GetFertilizerResponse.empty(String message) =>
      GetFertilizerResponse(message: message, fertilizers: []);

  factory GetFertilizerResponse.fromJson(Map<String, dynamic> json) =>
      GetFertilizerResponse(
        message: json["message"],
        fertilizers: List<Fertilizer>.from(
            json["fertilizers"].map((x) => Fertilizer.fromJson(x))),
      );
}

class Fertilizer {
  final int id;
  final String name;
  final String definition;
  final String benefits;
  final String instructions;

  Fertilizer({
    required this.id,
    required this.name,
    required this.definition,
    required this.benefits,
    required this.instructions,
  });

  factory Fertilizer.fromJson(Map<String, dynamic> json) => Fertilizer(
        id: json["id"],
        name: json["name"],
        definition: json["definition"],
        benefits: json["benefits"],
        instructions: json["instructions"],
      );
}
