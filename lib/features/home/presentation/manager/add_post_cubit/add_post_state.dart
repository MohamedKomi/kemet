part of 'add_post_cubit.dart';

@immutable
abstract class AddPostState {}

class AddPostInitial extends AddPostState {}
class AddPostLoading extends AddPostState {}
class AddLocationLoading extends AddPostState {}
class ChangeIsImage extends AddPostState {}
class FillControllerSuccess extends AddPostState {}
class FillControllerFailure extends AddPostState {}
class AddPostSuccess extends AddPostState {
  final AddPostModel addPostModel;

  AddPostSuccess(this.addPostModel);

}
class AddPostFailure extends AddPostState {
  final String errorMessage;

  AddPostFailure(this.errorMessage);
}
