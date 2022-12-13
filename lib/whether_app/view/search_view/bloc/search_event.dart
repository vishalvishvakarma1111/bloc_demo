part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SubmitEvent extends SearchEvent {
  final String query;

  SubmitEvent(this.query);
}
