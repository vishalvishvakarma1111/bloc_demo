part of 'add_note_bloc.dart';

@immutable
abstract class AddNoteState {}

class AddNoteInitial extends AddNoteState {}

class LoadingState extends AddNoteState {}

class ErrorState extends AddNoteState {
  final String errorMsg;

  ErrorState({required this.errorMsg});
}

class AddNotesSuccess extends AddNoteState {}
