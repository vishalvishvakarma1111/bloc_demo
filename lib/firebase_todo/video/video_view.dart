import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psspl_bloc_demo/firebase_todo/video/bloc/video_bloc.dart';
import 'package:psspl_bloc_demo/firebase_todo/video/video_item.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatelessWidget {
  const VideoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoBloc()..add(LoadVideoEvent()),
      child: BlocBuilder<VideoBloc, VideoState>(
        builder: (context, state) {
          return Scaffold(
            body: Visibility(
                visible: state is VideoLoaded,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: state.urlList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = state.urlList[index];
                    return VideoItemView(
                      url: item.url,
                    );
                  },
                )),
          );
        },
      ),
    );
  }
}
