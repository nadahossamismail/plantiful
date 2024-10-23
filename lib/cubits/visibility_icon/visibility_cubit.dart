import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'visibility_state.dart';

enum PasswordOrConfirmation { password, confirmPassword }

class VisibilityCubit extends Cubit<VisibilityState> {
  VisibilityCubit() : super(VisibilityOff());
  static VisibilityCubit get(context) => BlocProvider.of(context);

  var visiblePassword = true;
  var visibleConfirmPassword = true;

  IconButton visibilityIcon(PasswordOrConfirmation status) {
    var isPassword = status == PasswordOrConfirmation.password;
    var visibilityVariable =
        isPassword ? visiblePassword : visibleConfirmPassword;

    var visibilityIcon = visibilityVariable
        ? const Icon(Icons.remove_red_eye)
        : const Icon(Icons.visibility_off);

    return IconButton(
        icon: visibilityIcon,
        onPressed: () {
          if (isPassword) {
            visiblePassword = !visiblePassword;
          } else {
            visibleConfirmPassword = !visibleConfirmPassword;
          }
          visibilityVariable ? emit(VisibilityOn()) : emit(VisibilityOff());
        });
  }
}
