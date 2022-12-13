part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginInitialEvent extends LoginEvent {}

class LoginBtnTapEvent extends LoginEvent {
  String email;
  String pwd;

  LoginBtnTapEvent({required this.email, required this.pwd});
}
