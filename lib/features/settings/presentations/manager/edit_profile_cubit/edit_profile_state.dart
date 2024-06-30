part of 'edit_profile_cubit.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final EditProfileModel editProfileModel;

  EditProfileSuccess(this.editProfileModel);
}

class EditProfileFailure extends EditProfileState {
  final String message;

  EditProfileFailure(this.message);
}
