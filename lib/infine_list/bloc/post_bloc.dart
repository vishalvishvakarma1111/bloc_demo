import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:psspl_bloc_demo/infine_list/post_model.dart';
import 'package:http/http.dart' as http;

part 'post_event.dart';

part 'post_state.dart';

const _postLimit = 20;

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({required this.httpClient}) : super(PostState()) {
    on<PostFetched>(_onPostFetched);
    on<LoadMorePosts>(_onLoadMore);
  }

  FutureOr<void> _onPostFetched(
      PostFetched event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) {
      return;
    }

    try {
      if (state.status == PostStatus.initial) {
        final posts = await callFetchPostApi();
        emit(
          state.copyWith(
            status: PostStatus.success,
            posts: posts,
            hasReachedMax: false,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure));
      print(e);
    }
  }

  Future<List<Post>> callFetchPostApi({int startIndex = 0}) async {
    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Post(
          id: map['id'] as int,
          title: map['title'] as String,
          body: map['body'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }

  FutureOr<void> _onLoadMore(
      LoadMorePosts event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) {
      return;
    }

    emit(state.copyWith(
      status: PostStatus.success,
      posts: state.posts,
      hasReachedMax: false,
      bottomLoader: true,
    ));
    await Future.delayed(const Duration(seconds: 3));

    final posts = await callFetchPostApi(startIndex: state.posts.length);
    print("------asdsdf-----    -${posts.length}");
    posts.isEmpty
        ? emit(
            state.copyWith(
              hasReachedMax: true,
              bottomLoader: false,
            ),
          )
        : emit(
            state.copyWith(
                status: PostStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: false,
                bottomLoader: false),
          );
  }
}
