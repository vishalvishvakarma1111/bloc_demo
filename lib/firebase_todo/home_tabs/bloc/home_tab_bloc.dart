import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:psspl_bloc_demo/firebase_todo/home/homeview.dart';
import 'package:psspl_bloc_demo/firebase_todo/video/video_view.dart';

import '../../profile/profile_view.dart';

part 'home_tab_event.dart';

part 'home_tab_state.dart';

class HomeTabBloc extends Bloc<HomeTabEvent, HomeTabState> {
  HomeTabBloc() : super(HomeTabInitial(0)) {
    on<HomeTabEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<HomeTapEvent>((event, emit) {
      emit(HomeTabInitial(event.index));
    });
  }
}
