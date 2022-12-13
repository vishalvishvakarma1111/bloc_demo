part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeLoadNotesEvent extends HomeEvent {
  List<Notes> notesList;

  HomeLoadNotesEvent(this.notesList);
}

class HomeDeleteNoteEvent extends HomeEvent {
  final Notes notes;
  List<Notes> notesList;

  HomeDeleteNoteEvent({required this.notes, required this.notesList});
}
