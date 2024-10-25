import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantiful/data_layer.dart/models/get_plants_response.dart';

part 'firestore_state.dart';

class FirestoreCubit extends Cubit<FirestoreState> {
  FirestoreCubit() : super(FirebasefirestoreInitial());

  static FirestoreCubit get(context) => BlocProvider.of(context);
  final database = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  addPlant({required Plant plant}) {
    emit(AddPlantLoading());
    try {
      database.collection("garden").doc(userId).update({
        'plants': FieldValue.arrayUnion([plant.toJson()])
      });
      emit(AddPlantSuccess());
    } catch (e) {
      emit(FirebasefirestoreFailure());
    }
  }

  removePlant({required Plant plant}) {
    emit(AddPlantLoading());
    try {
      database.collection("garden").doc(userId).update({
        'plants': FieldValue.arrayRemove([plant.toJson()])
      });
      emit(AddPlantSuccess());
    } catch (e) {
      emit(FirebasefirestoreFailure());
    }
  }

  getAllPlants() async {
    List<dynamic> plants = [];
    emit(GetplantsLoading());
    try {
      DocumentSnapshot documentSnapshot =
          await database.collection("garden").doc(userId).get();
      if (documentSnapshot.exists && documentSnapshot.data() != null) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        if (data.containsKey("plants")) {
          plants = documentSnapshot["plants"];
          emit(GetPlantsSuccess(
              gardenPlants:
                  plants.map((plant) => Plant.fromJson(plant)).toList()));
        } else {
          emit(GetPlantsSuccess(gardenPlants: []));
        }
      }
    } catch (e) {
      log("$e");
      emit(FirebasefirestoreFailure());
    }
  }
}
