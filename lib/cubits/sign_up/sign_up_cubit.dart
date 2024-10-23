import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantiful/data_layer.dart/network/firebase_error_handler.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit get(context) => BlocProvider.of(context);

  signUpUser(
      {required String email,
      required String password,
      required userName}) async {
    emit(SignUpLoading());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(SignUpCompleted());
    } on FirebaseAuthException catch (e) {
      AuthResultStatus authResultStatus =
          AuthExceptionHandler.handleException(e);
      emit(SignUpFailure(
          AuthExceptionHandler.generateExceptionMessage(authResultStatus)));
    }
  }
}
