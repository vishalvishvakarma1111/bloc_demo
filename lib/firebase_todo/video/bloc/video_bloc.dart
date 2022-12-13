import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:psspl_bloc_demo/firebase_todo/model/video.dart';
import 'package:video_player/video_player.dart';

part 'video_event.dart';

part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  late VideoPlayerController controller;

  VideoBloc() : super(const VideoInitial([])) {
    on<VideoEvent>((event, emit) {});
    on<LoadVideoEvent>(_loadVideo);
  }

  FutureOr<void> _loadVideo(LoadVideoEvent event, Emitter<VideoState> emit) {
    emit(VideoLoader());
    state.urlList.add(VideoModel(
        url:
            "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"));
    state.urlList.add(VideoModel(
        url:
            "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"));
    state.urlList.add(VideoModel(
        url:
            "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"));
    state.urlList.add(VideoModel(
        url:
            "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"));
    state.urlList.add(VideoModel(
        url:
            "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"));
    state.urlList.add(VideoModel(
        url:
            "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4"));
    state.urlList.add(VideoModel(
        url:
            "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4"));
    state.urlList.add(VideoModel(
        url:
            "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"));
    state.urlList.add(VideoModel(
        url:
            "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4"));
    state.urlList.add(VideoModel(
        url:
            "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"));
    state.urlList.add(VideoModel(
        url:
            "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4"));
    state.urlList.add(VideoModel(
        url:
            "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"));
    state.urlList.add(VideoModel(
        url:
            "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4"));

    emit(VideoLoaded(urlList: state.urlList));
  }
}
