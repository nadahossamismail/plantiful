import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantiful/main.dart';
import 'package:weather/weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  static WeatherCubit get(context) => BlocProvider.of(context);
  WeatherFactory wf = WeatherFactory("f90fbeb55d27c0288f7b4b532f8ccbf1");

  String waetherIcon(WeatherState state) {
    if (state is WeatherLoading) {
      return "http://openweathermap.org/img/wn/10d@2x.png";
    } else if (state is WeatherSuccess) {
      return "http://openweathermap.org/img/wn/${state.weather.weatherIcon}@2x.png";
    }
    return "";
  }

  getWeather() async {
    var lat = preferences.getDouble("lat");
    var lon = preferences.getDouble("lon");

    if (lat == null || lon == null) {
      emit(WeatherNotpermitted());
    }

    emit(WeatherLoading());
    try {
      Weather weather = await wf.currentWeatherByLocation(lat!, lon!);
      log(weather.country!);
      log(weather.areaName!);
      emit(WeatherSuccess(weather: weather));
    } catch (e) {
      emit(WeatherFailure());
    }
  }
}
