import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:meta/meta.dart';

part 'add_note_event.dart';

part 'add_note_state.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  AddNoteBloc() : super(AddNoteInitial()) {
    on<AddNoteEvent>((event, emit) {});
    on<AddNotesTap>(_onSubmit);
    on<UpdateNotesTap>(_onUpdateNotes);
  }

  Future<FutureOr<void>> _onSubmit(
      AddNotesTap event, Emitter<AddNoteState> emit) async {
    if (event.title.isEmpty) {
      emit(ErrorState(errorMsg: "Please enter title"));
    } else if (event.desc.isEmpty) {
      emit(ErrorState(errorMsg: "Please enter description"));
    } else {
      emit(LoadingState());
      try {
        CollectionReference notes =
            FirebaseFirestore.instance.collection('notes');
        DocumentReference<Object?> res = await notes.add({
          "title": event.title,
          "description": event.desc,
          "created_time": DateTime.now().toString(),
          "user_id": FirebaseAuth.instance.currentUser?.uid.toString(),
        });
        emit(AddNotesSuccess());
      } catch (e) {
        emit(ErrorState(errorMsg: e.toString()));

        log("message---error ", error: e.toString());
      }
    }
  }

  FutureOr<void> _onUpdateNotes(
      UpdateNotesTap event, Emitter<AddNoteState> emit) async {
    if (event.title.isEmpty) {
      emit(ErrorState(errorMsg: "Please enter title"));
    } else if (event.desc.isEmpty) {
      emit(ErrorState(errorMsg: "Please enter description"));
    } else {
      emit(LoadingState());
      try {
        CollectionReference notes =
            FirebaseFirestore.instance.collection('notes');
        await notes.doc(event.id).set({
          "title": event.title,
          "description": event.desc,
          "update_time": DateTime.now().toString(),
          "user_id": FirebaseAuth.instance.currentUser?.uid.toString(),
        });
        emit(AddNotesSuccess());
      } catch (e) {
        emit(ErrorState(errorMsg: e.toString()));

        log("message---error ", error: e.toString());
      }
    }
  }
}
