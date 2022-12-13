import 'package:flutter/material.dart';

@immutable
abstract class OtpEvent {}

class SubmitEvent extends OtpEvent {
  final String otp;
  final String verificationId;

  SubmitEvent({required this.otp, required this.verificationId});
}

class ResendOtpEvent extends OtpEvent {
  final String phone;

  ResendOtpEvent({required this.phone});
}




class OtpSuccessEvent extends OtpEvent {
  final String phone;
  final String verificationId;

  OtpSuccessEvent({required this.phone, required this.verificationId});
}

class OtpErrorEvent extends OtpEvent {
  final String phone;

  OtpErrorEvent(this.phone);
}

