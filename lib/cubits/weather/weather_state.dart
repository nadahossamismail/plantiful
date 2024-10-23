part of 'weather_cubit.dart';

sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final Weather weather;

  WeatherSuccess({required this.weather});
}

final class WeatherNotpermitted extends WeatherState {}

final class WeatherFailure extends WeatherState {}
