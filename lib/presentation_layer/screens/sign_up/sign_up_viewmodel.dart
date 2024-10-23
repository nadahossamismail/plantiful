import 'package:flutter/material.dart';
import 'package:plantiful/core/app_routes.dart';
import 'package:plantiful/core/app_strings.dart';
import 'package:plantiful/cubits/sign_up/sign_up_cubit.dart';
import 'package:plantiful/presentation_layer/widgets/alert_dialog.dart';

class SignUpViewModel {
  var formkey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController usernameController;

  void init() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    usernameController = TextEditingController();
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    usernameController.dispose();
  }

  String? validateUserName(String? username) {
    if (username == null || username.isEmpty) {
      return AppStrings.emptyField;
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return AppStrings.emptyField;
    } else if (!email.contains("@")) {
      return AppStrings.notValid;
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return AppStrings.emptyField;
    } else if (password.length < 8) {
      return AppStrings.passwordTooShort;
    }
    return null;
  }

  String? validateConfirmPassword(String? password) {
    if (password == null || password.isEmpty) {
      return AppStrings.emptyField;
    } else if (password.compareTo(passwordController.text) != 0) {
      return AppStrings.notMatched;
    }
    return null;
  }

  void listener(context, state) {
    if (state is SignUpFailure) {
      AppAlertDialog.showAlert(context, state.message);
    } else if (state is SignUpCompleted) {
      Navigator.of(context).pushReplacementNamed(Routes.locationSettingRoute);
    }
  }

  void signUp(context) {
    if (formkey.currentState!.validate()) {
      SignUpCubit.get(context).signUpUser(
          email: emailController.text,
          password: passwordController.text,
          userName: usernameController.text);
    }
  }
}
