part of 'posts_cubit.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsSuccess extends PostsState {
  final PostsModel postsModel;

  PostsSuccess(this.postsModel);
}

class PostsFailure extends PostsState {
  final String message;

  PostsFailure(this.message);
}
