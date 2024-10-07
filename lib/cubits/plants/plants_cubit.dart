import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantiful/core/app_strings.dart';
import 'package:plantiful/data_layer.dart/api_requests/get_plants.dart';
import 'package:plantiful/data_layer.dart/models/get_plants_response.dart';

part 'plants_state.dart';

class PlantsCubit extends Cubit<PlantsState> {
  PlantsCubit() : super(PlantsInitial());

  static PlantsCubit get(context) => BlocProvider.of(context);

  List<Plant> plants = [];

  void sendRequest() async {
    GetPlantsResponse response;

    emit(PlantsLoading());

    response = await GetPlants().send();

    if (response.message == AppStrings.failure) {
      emit(PlantsFailure(response.message));
    } else {
      plants = response.plants;
      emit(PlantsSuccess());
    }
  }
}
