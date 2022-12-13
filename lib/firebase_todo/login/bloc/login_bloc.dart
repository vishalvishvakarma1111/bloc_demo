import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginInitialEvent>(_init);
    on<LoginBtnTapEvent>(_loginTap);
  }

  FutureOr<void> _init(LoginInitialEvent event, Emitter<LoginState> emit) {
    emit(LoginLoadedState());
  }

  FutureOr<void> _loginTap(
      LoginBtnTapEvent event, Emitter<LoginState> emit) async {
    if (event.email.isEmpty) {
      emit(LoginErrorState(msg: "Please enter email"));
    } else if (event.pwd.isEmpty) {
      emit(LoginErrorState(msg: "Please enter password "));
    } else {
      emit(LoginLoadedState(loader: true));
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: event.email, password: event.pwd);

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
          emit(LoginSuccess());
        }
      } on FirebaseAuthException catch (e) {
        emit(LoginErrorState(msg: e.message.toString()));
      }

      emit(LoginLoadedState(loader: false));
    }
  }
}
