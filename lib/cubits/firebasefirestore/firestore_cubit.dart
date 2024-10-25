import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantiful/core/app_strings.dart';
import 'package:plantiful/data_layer.dart/models/get_plants_response.dart';
part 'firestore_state.dart';

class FirestoreCubit extends Cubit<FirestoreState> {
  FirestoreCubit() : super(FirestoreInitial());

  static FirestoreCubit get(context) => BlocProvider.of(context);
  final database = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  addPlant({required Plant plant}) {
    emit(AddPlantLoading());
    try {
      database.collection(AppStrings.collectionName).doc(userId).update({
        AppStrings.listKey: FieldValue.arrayUnion([plant.toJson()])
      });
      emit(AddPlantSuccess());
    } catch (e) {
      emit(FirestoreFailure());
    }
  }

  removePlant({required Plant plant}) {
    emit(RemovePlantLoading());
    try {
      database.collection(AppStrings.collectionName).doc(userId).update({
        AppStrings.listKey: FieldValue.arrayRemove([plant.toJson()])
      });
      emit(RemovePlantSuccess());
    } catch (e) {
      emit(FirestoreFailure());
    }
  }

  getAllPlants() async {
    List<dynamic> plants = [];
    emit(GetplantsLoading());
    try {
      DocumentSnapshot documentSnapshot = await database
          .collection(AppStrings.collectionName)
          .doc(userId)
          .get();
      if (documentSnapshot.exists && documentSnapshot.data() != null) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        if (data.containsKey(AppStrings.listKey)) {
          plants = documentSnapshot[AppStrings.listKey];
          emit(GetPlantsSuccess(
              gardenPlants:
                  plants.map((plant) => Plant.fromJson(plant)).toList()));
        } else {
          emit(GetPlantsSuccess(gardenPlants: []));
        }
      }
    } catch (e) {
      log("$e");
      emit(FirestoreFailure());
    }
  }
}
