part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class SignupTapped extends SignupEvent {
  String email, password;

  SignupTapped({
    required this.email,
    required this.password,
  });
}
