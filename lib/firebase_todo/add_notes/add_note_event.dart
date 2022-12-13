part of 'add_note_bloc.dart';

@immutable
abstract class AddNoteEvent {}

class AddNotesTap extends AddNoteEvent {
  final String title, desc;

  AddNotesTap({required this.title, required this.desc});
}

class UpdateNotesTap extends AddNoteEvent {
  final String title, desc, id;

  UpdateNotesTap({required this.title, required this.desc, required this.id});
}
