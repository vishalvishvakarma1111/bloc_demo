part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoader extends SearchState {}

class SearchSuccess extends SearchState {
  final Location? location;
  SearchSuccess(this.location);
}

class ErrorState extends SearchState {
  final String errorMsg;

  ErrorState(this.errorMsg);
}
