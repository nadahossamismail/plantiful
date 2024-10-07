part of 'plants_cubit.dart';

sealed class PlantsState {}

final class PlantsInitial extends PlantsState {}

final class PlantsLoading extends PlantsState {}

final class PlantsSuccess extends PlantsState {}

final class PlantsFailure extends PlantsState {
  final String message;

  PlantsFailure(this.message);
}
