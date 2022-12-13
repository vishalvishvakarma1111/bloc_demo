part of 'otp_login_bloc.dart';

@immutable
abstract class OtpLoginEvent {}

class SubmitEvent extends OtpLoginEvent {
  final String phone;

  SubmitEvent(this.phone);
}

class ResendOtpEvent extends OtpLoginEvent {}

class OtpSuccessEvent extends OtpLoginEvent {
  final String phone;
  final String verificationId;

  OtpSuccessEvent({required this.phone, required this.verificationId});
}

class OtpErrorEvent extends OtpLoginEvent {
  final String phone;

  OtpErrorEvent(this.phone);
}
