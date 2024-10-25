import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantiful/data_layer.dart/network/firebase_error_handler.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  final auth = FirebaseAuth.instance;

  loginUser({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      emit(LoginCompleted());
    } on FirebaseAuthException catch (e) {
      log(e.code);
      AuthResultStatus authResultStatus =
          AuthExceptionHandler.handleException(e);
      emit(LoginFailure(
          AuthExceptionHandler.generateExceptionMessage(authResultStatus)));
    }
  }
}
