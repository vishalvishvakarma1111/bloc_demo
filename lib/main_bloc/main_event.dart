part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class InitEvent extends MainEvent{}

class InternetEvent extends MainEvent {
  final bool isConnected;

  InternetEvent(this.isConnected);
}
