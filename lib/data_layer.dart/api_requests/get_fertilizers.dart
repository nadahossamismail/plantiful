import 'package:dio/dio.dart';
import 'package:plantiful/core/api_constants.dart';
import 'package:plantiful/data_layer.dart/models/get_fertilizers_response.dart';
import 'package:plantiful/data_layer.dart/network/dio_factory.dart';
import 'package:plantiful/data_layer.dart/network/error_handler.dart';

class GetFertilizersRequest {
  final dio = DioFactory.getDio();

  Future<GetFertilizerResponse> send() async {
    Response response;
    GetFertilizerResponse fertilizersResponse;

    try {
      response = await dio.get(ApiEndpoints.fertilizers);

      fertilizersResponse = GetFertilizerResponse.fromJson(response.data);

      return fertilizersResponse;
    } catch (error) {
      var handler = ErrorHandler.handle(error);
      return GetFertilizerResponse.empty(handler.failure.message);
    }
  }
}
