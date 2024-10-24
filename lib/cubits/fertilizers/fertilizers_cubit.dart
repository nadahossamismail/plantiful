import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantiful/core/app_strings.dart';
import 'package:plantiful/data_layer.dart/api_requests/get_fertilizers.dart';
import 'package:plantiful/data_layer.dart/models/get_fertilizers_response.dart';

part 'fertilizers_state.dart';

class FertilizersCubit extends Cubit<FertilizersState> {
  FertilizersCubit() : super(FertilizersInitial());

  static FertilizersCubit get(context) => BlocProvider.of(context);

  void getFertilizers() async {
    GetFertilizerResponse response;

    emit(FertilizersLoading());

    response = await GetFertilizersRequest().send();

    if (response.message == AppStrings.success) {
      emit(FertilizersSuccess(fertilizers: response.fertilizers));
    } else {
      emit(FertilizersFailure(message: response.message));
    }
  }
}
