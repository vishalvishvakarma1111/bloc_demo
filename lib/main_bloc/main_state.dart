part of 'main_bloc.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}

class InternetLostState extends MainState {}

class InternetGainedState extends MainState {}
