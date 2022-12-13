part of 'timer_bloc.dart';

@immutable
abstract class TimerEvent {}

class TimerStarted extends TimerEvent {
  final int duration;

  TimerStarted({required this.duration});
}

class TimerPaused extends TimerEvent {}

class TimerResumed extends TimerEvent {}

class TimerReset extends TimerEvent {}

class TimerTicked extends TimerEvent {
  int duration;

  TimerTicked({required this.duration});
}
