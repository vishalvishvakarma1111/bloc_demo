part of 'post_bloc.dart';

enum PostStatus { initial, success, failure }

@immutable
class PostState {
  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;
  final bool bottomLoader;

  PostState({
    this.status = PostStatus.initial,
    this.posts = const [],
    this.hasReachedMax = false,
    this.bottomLoader = false,
  });

  PostState copyWith(
      {PostStatus? status,
      List<Post>? posts,
      bool? hasReachedMax,
      bool? bottomLoader}) {
    print("-------- load more -----------     $bottomLoader");
    return PostState(
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        posts: posts ?? this.posts,
        status: status ?? this.status,
        bottomLoader: bottomLoader ?? this.bottomLoader);
  }

  @override
  String toString() {
    return 'PostState{status: $status, posts:, hasReachedMax: $hasReachedMax, bottomLoader: $bottomLoader}';
  }
}
