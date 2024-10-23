part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpCompleted extends SignUpState {}

final class SignUpFailure extends SignUpState {
  final String? message;
  SignUpFailure(this.message);
}
