import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psspl_bloc_demo/timer_demo/tcker.dart';

import '../../my_imports.dart';

part 'timer_event.dart';

part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _duration = 60;

  final Ticker? _ticker;
  StreamSubscription<int>? tickerSubscription;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(TimerInitial(_duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerTicked>(_onTicked);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
  }

  @override
  Future<void> close() {
    tickerSubscription?.cancel();
    return super.close();
  }

  FutureOr<void> _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    tickerSubscription?.cancel();
    tickerSubscription =
        _ticker?.tick(ticks: event.duration).listen((duration) {
      add(TimerTicked(duration: duration));
    });
  }

  FutureOr<void> _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(event.duration > 0
        ? TimerRunInProgress(event.duration)
        : TimerRunComplete());
  }

  FutureOr<void> _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }

  FutureOr<void> _onResumed(TimerResumed event, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  FutureOr<void> _onReset(TimerReset event, Emitter<TimerState> emit) {
    tickerSubscription?.cancel();
    emit(TimerInitial(_duration));
  }
}
