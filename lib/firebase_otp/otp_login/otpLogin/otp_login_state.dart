part of 'otp_login_bloc.dart';

@immutable
abstract class OtpLoginState {}

class OtpLoginInitial extends OtpLoginState {}

class LoaderState extends OtpLoginState {}

class ErrorState extends OtpLoginState {
  final String msg;

  ErrorState({required this.msg});
}

class OtpLoginSuccess extends OtpLoginState {
  final String verificationId, phone;

  OtpLoginSuccess({required this.verificationId, required this.phone});
}
