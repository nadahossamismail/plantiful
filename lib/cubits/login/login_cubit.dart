import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantiful/data_layer.dart/network/firebase_error_handler.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  loginUser({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

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

void saveToken(token, name, email) {}
