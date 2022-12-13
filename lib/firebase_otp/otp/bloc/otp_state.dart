import 'package:flutter/material.dart';

@immutable
abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoaderState extends OtpState {}

class ErrorState extends OtpState {
  final String msg;

  ErrorState(this.msg);
}

class OtpSuccessState extends OtpState {}
class ResendOtpLoaderState extends OtpState {}
