import 'package:flutter/material.dart';
import 'package:plantiful/core/app_strings.dart';
import 'package:plantiful/cubits/login/login_cubit.dart';

class LoginViewModel {
  var formkey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordContoller;

  void init() {
    emailController = TextEditingController();
    passwordContoller = TextEditingController();
  }

  void dispose() {
    emailController.dispose();
    passwordContoller.dispose();
  }

  String? validateEmail(email) {
    if (email == null || email.isEmpty) {
      return AppStrings.emptyField;
    } else if (!email.contains("@")) {
      return AppStrings.notValid;
    }
    return null;
  }

  String? validatePassword(password) {
    if (password == null || password.isEmpty) {
      return AppStrings.emptyField;
    }
    return null;
  }

  void login(context) {
    if (formkey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      LoginCubit.get(context).loginUser(
          email: emailController.text, password: passwordContoller.text);
    }
  }
}
