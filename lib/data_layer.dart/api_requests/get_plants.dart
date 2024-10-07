import 'package:dio/dio.dart';
import 'package:plantiful/core/api_constants.dart';
import 'package:plantiful/data_layer.dart/models/get_plants_response.dart';
import 'package:plantiful/data_layer.dart/network/dio_factory.dart';
import 'package:plantiful/data_layer.dart/network/error_handler.dart';

class GetPlants {
  final dio = DioFactory.getDio();

  Future<GetPlantsResponse> send() async {
    Response response;
    GetPlantsResponse plants;

    try {
      response = await dio.get(ApiEndpoints.plants);

      plants = GetPlantsResponse.fromJson(response.data);

      return plants;
    } catch (error) {
      var message = ErrorHandler.handle(error).failure.message;
      return GetPlantsResponse.empty(message);
    }
  }
}
