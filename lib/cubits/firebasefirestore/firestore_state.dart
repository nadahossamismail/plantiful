part of 'firestore_cubit.dart';

sealed class FirestoreState {}

final class FirebasefirestoreInitial extends FirestoreState {}

final class AddPlantLoading extends FirestoreState {}

final class GetplantsLoading extends FirestoreState {}

final class GetPlantsSuccess extends FirestoreState {
  final List<Plant> gardenPlants;

  GetPlantsSuccess({required this.gardenPlants});
}

final class AddPlantSuccess extends FirestoreState {}

final class FirebasefirestoreFailure extends FirestoreState {}
