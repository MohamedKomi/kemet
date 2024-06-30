part of 'edit_photo_cubit.dart';


abstract class EditPhotoState {}

class EditPhotoInitial extends EditPhotoState {}

class EditPhotoLoading extends EditPhotoState {}

class EditPhotoSuccess extends EditPhotoState {
  final EditProfileModel editProfileModel;

  EditPhotoSuccess(this.editProfileModel);
}

class EditPhotoFailure extends EditPhotoState {
  final String message;

  EditPhotoFailure(this.message);
}
