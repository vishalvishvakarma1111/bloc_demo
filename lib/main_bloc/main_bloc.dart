import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  MainBloc() : super(MainInitial()) {
    on<MainEvent>((event, emit) {});
    on<InitEvent>(_init);

    on<InternetEvent>((event, emit) {
      emit(event.isConnected ? InternetGainedState() : InternetLostState());
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }

  FutureOr<void> _init(InitEvent event, Emitter<MainState> emit) {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((connectivityResult) {
      bool value = false;
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        value = true;
      }
      add(InternetEvent(value));
    });
  }
}
