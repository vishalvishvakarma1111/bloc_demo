import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupEvent>((event, emit) {});
    on<SignupTapped>(_onSignupTap);
  }

  FutureOr<void> _onSignupTap(
      SignupTapped event, Emitter<SignupState> emit) async {
    if (event.email.isEmpty) {
      emit(SignupFailure(errorMsg: "Please enter email"));
    } else if (event.password.isEmpty) {
      emit(SignupFailure(errorMsg: "Please enter password"));
    } else {
      try {
        emit(SignupLoader());

        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user?.uid ?? "")
            .set(
          {
            'name': "",
            'desc': "",
            'profile': "",
            'uid': credential.user?.uid ?? "",
          },
        );

        if (credential.user != null) {
          emit(SignupSuccess());
        }
      } on FirebaseAuthException catch (e) {
        emit(SignupFailure(errorMsg: e.message.toString()));
      }
      emit(SignupInitial());

      //SignupSuccess();
    }
  }
}
