import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:psspl_bloc_demo/firebase_todo/model/profile.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<LogoutTapEvent>(_logout);
    on<LoadProfile>(_loadProfile);
    on<UpdateProfileEvent>(_updateProfile);
    on<SelectPhotoEvent>(_selectPhoto);
  }

  FutureOr<void> _logout(LogoutTapEvent event, Emitter<ProfileState> emit) {}

  Future<FutureOr<void>> _loadProfile(
      LoadProfile event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoader());
    try {
      QuerySnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance
          .collection("users")
          .where("uid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get();
      Map<String, dynamic> map = doc.docs.first.data();
      Profile profile = Profile.fromJson(map);
      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      print(e);
      emit(ProfileError(msg: e.toString()));
    }
  }

  Future<FutureOr<void>> _updateProfile(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    ProfileLoaded lastState = state as ProfileLoaded;
    emit(const ProfileUpdateLoader());
    if (lastState.profile.file != null) {
      final storage =
          FirebaseStorage.instance.ref().child("/images/profile_pic");
      TaskSnapshot taskSnapshot =
          await storage.putFile(File(lastState.profile.file?.path ?? ""));

      String url = await taskSnapshot.ref.getDownloadURL();
      lastState.profile.url = url;
    }

    Map<String, dynamic> map = {};
    map["name"] = event.profile.name ?? "";
    map["desc"] = event.profile.desc ?? "";
    map["profile_pic"] = lastState.profile.url ?? "";
    map["uid"] = FirebaseAuth.instance.currentUser?.uid ?? "";

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
        .set(map);

    var profile = Profile(
      desc: event.profile.desc,
      name: event.profile.name,
      url: lastState.profile.url,
    );
    emit(const ProfileSuccess());
    emit(ProfileLoaded(profile: profile));
  }

  FutureOr<void> _selectPhoto(
      SelectPhotoEvent event, Emitter<ProfileState> emit) {
    ProfileLoaded lastState = state as ProfileLoaded;
    emit(ProfileLoaded(
        profile: Profile(
      name: lastState.profile.name,
      desc: lastState.profile.desc,
      file: event.profile.file,
    )));
  }
}
