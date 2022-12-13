part of 'post_bloc.dart';

@immutable
abstract class PostEvent extends Equatable {}

class PostFetched extends PostEvent {
  @override
  List<Object?> get props => [];
}

class LoadMorePosts extends PostEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
