part of 'video_bloc.dart';

@immutable
abstract class VideoState {
  final List<VideoModel> urlList;

  const VideoState(this.urlList);
}

class VideoInitial extends VideoState {
  const VideoInitial(super.urlList);
}

class VideoLoaded extends VideoState {
  final List<VideoModel> urlList;

  VideoLoaded({required this.urlList}) : super(urlList);
}

class VideoLoader extends VideoState {
  VideoLoader() : super([]);
}
