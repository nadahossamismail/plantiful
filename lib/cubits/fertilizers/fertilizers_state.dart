part of 'fertilizers_cubit.dart';

sealed class FertilizersState {}

final class FertilizersInitial extends FertilizersState {}

final class FertilizersLoading extends FertilizersState {}

final class FertilizersFailure extends FertilizersState {
  final String message;

  FertilizersFailure({required this.message});
}

final class FertilizersSuccess extends FertilizersState {}
