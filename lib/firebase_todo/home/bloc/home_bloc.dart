import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psspl_bloc_demo/firebase_todo/model/ntoes_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<HomeLoadNotesEvent>(_loadNotesList);
    on<HomeDeleteNoteEvent>(_deleteNotes);
  }

  Future<FutureOr<void>> _loadNotesList(
      HomeLoadNotesEvent event, Emitter<HomeState> emit) async {
    emit(LoaderState());
    Stream<QuerySnapshot<Object?>> res = notes
        .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots();

    await res.forEach((snapshot) {
      event.notesList = [];
      if (snapshot.docs.isEmpty) {
        emit(HomeLoaded(notesList: event.notesList));
      } else {
        for (var element in snapshot.docs) {
          Map<String, dynamic> data = element.data()! as Map<String, dynamic>;
          event.notesList.add(Notes.fromJson(data, element.id));
          emit(HomeLoaded(notesList: event.notesList));
        }
      }
    });
  }

  FutureOr<void> _deleteNotes(
      HomeDeleteNoteEvent event, Emitter<HomeState> emit) {
    int index = event.notesList.indexOf(event.notes);
    event.notesList[index].loader = true;
    emit(HomeLoaded(notesList: event.notesList));
    notes.doc(event.notes.id).delete();
  }
}
