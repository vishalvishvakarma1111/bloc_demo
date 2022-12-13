import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_login_event.dart';

part 'otp_login_state.dart';

class OtpLoginBloc extends Bloc<OtpLoginEvent, OtpLoginState> {
  OtpLoginBloc() : super(OtpLoginInitial()) {
    on<OtpLoginEvent>((event, emit) {});
    on<SubmitEvent>(_submit);
    on<OtpSuccessEvent>(_otpSentSuccess);
  }

  Future<FutureOr<void>> _submit(
      SubmitEvent event, Emitter<OtpLoginState> emit) async {
    emit(LoaderState());
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${event.phone}',
        timeout: const Duration(seconds: 30),
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          add(OtpErrorEvent(e.message.toString()));
        },
        codeSent: (String verificationId, int? resendToken) {
          add(OtpSuccessEvent(
              phone: event.phone, verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      emit(ErrorState(msg: e.message.toString()));
    }
  }

  FutureOr<void> _otpSentSuccess(
      OtpSuccessEvent event, Emitter<OtpLoginState> emit) {
    emit(OtpLoginSuccess(
        verificationId: event.verificationId, phone: event.phone));
  }
}
