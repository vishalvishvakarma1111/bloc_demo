import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psspl_bloc_demo/firebase_otp/otp/bloc/otp_event.dart';
import 'package:psspl_bloc_demo/firebase_otp/otp/bloc/otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial()) {
    on<OtpEvent>((event, emit) {});
    on<OtpErrorEvent>((event, emit) {
      emit(ErrorState(event.phone));
    });
    on<SubmitEvent>(_submit);
    on<ResendOtpEvent>(_resendOtp);
    on<OtpSuccessEvent>((event, emit) {
      emit(OtpSuccessState());
    });
  }

  FutureOr<void> _resendOtp(ResendOtpEvent event, Emitter<OtpState> emit) {
    emit(ResendOtpLoaderState());
    try {
      FirebaseAuth.instance.verifyPhoneNumber(
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
      emit(ErrorState(e.message.toString()));
    }
  }

  FutureOr<void> _submit(SubmitEvent event, Emitter<OtpState> emit) async {
    submitOtp(emit, event.verificationId, event.otp);
  }

  void submitOtp(
      Emitter<OtpState> emit, String verificationId, String otp) async {
    try {
      emit(OtpLoaderState());

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);

      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((credential) {
        if (credential.user != null) {
          emit(OtpSuccessState());
        } else {
          emit(ErrorState("something went wrong"));
        }
      });
    } on FirebaseAuthException catch (e) {
      add(OtpErrorEvent(e.message.toString()));

      print(e);
    }
  }
}
