part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoader extends SignupState {}

class SignupFailure extends SignupState {
  String errorMsg;

  SignupFailure({required this.errorMsg});
}

class SignupSuccess extends SignupState {}
