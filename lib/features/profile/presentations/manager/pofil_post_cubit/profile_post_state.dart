part of 'profile_post_cubit.dart';


abstract class ProfilePostState {}

class ProfilePostInitial extends ProfilePostState {}
class ProfilePostLoading extends ProfilePostState {}
class ProfilePostSuccess extends ProfilePostState {
  final PostsModel data;

  ProfilePostSuccess(this.data);
}
class ProfilePostFailure extends ProfilePostState {
  final String errorMessage;

  ProfilePostFailure(this.errorMessage);

}
class DeleteProfilePostLoading extends ProfilePostState {}
class DeleteProfilePostSuccess extends ProfilePostState {
  final String data;

  DeleteProfilePostSuccess(this.data);
}
class DeleteProfilePostFailure extends ProfilePostState {
  final String errorMessage;

  DeleteProfilePostFailure(this.errorMessage);

}
