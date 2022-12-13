import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psspl_bloc_demo/infine_list/bloc/post_bloc.dart';
import 'package:http/http.dart' as http;

class PostView extends StatefulWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        (context).read<PostBloc>().add(LoadMorePosts());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<PostBloc>(context).add(PostFetched());
            },
            icon: const Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (BuildContext context, state) {
          print("  view screen post view $state");

          if (state.status == PostStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == PostStatus.success) {
            if (state.posts.isEmpty) {
              return const Center(
                child: Text(
                  "no Post ",
                  style: TextStyle(fontSize: 25),
                ),
              );
            }
            return Stack(
              children: [
                ListView.builder(
                  itemCount: state.posts.length,
                  controller: controller,
                  itemBuilder: (BuildContext context, int index) {
                    var item = state.posts[index];
                    return ListTile(
                      leading: Text(
                        index.toString(),
                        style: TextStyle(fontSize: 25),
                      ),
                      title: Text(item.title),
                      subtitle: Text(
                        item.body,
                      ),
                    );
                  },
                ),
                state.bottomLoader
                    ? const Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            );
          } else if (state.status == PostStatus.failure) {
            return const Center(
              child: Text(
                "Failed to fetch posts ",
                style: TextStyle(fontSize: 25),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
