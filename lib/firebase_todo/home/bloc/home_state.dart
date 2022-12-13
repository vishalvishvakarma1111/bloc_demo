part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoaderState extends HomeState {}

class FailureState extends HomeState {
  final String errorMsf;

  FailureState({required this.errorMsf});
}

class HomeLoaded extends HomeState {
  List<Notes> notesList;

  HomeLoaded({required this.notesList});
}
