part of 'timer_bloc.dart';

enum TimerStatus { initial, playing, stop }

@immutable
abstract class TimerState {
  final int duration;

  TimerState(this.duration);
}

class TimerInitial extends TimerState {
  TimerInitial(super.duration);
}

class TimerRunPause extends TimerState {
  TimerRunPause(super.duration);
}

class TimerRunInProgress extends TimerState {
  TimerRunInProgress(super.duration);
}

class TimerRunComplete extends TimerState {
  TimerRunComplete() : super(0);
}
