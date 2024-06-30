import 'dart:io';

import 'package:kemet/features/settings/data/models/edit_profile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/edit_profile_repo.dart';


part 'edit_photo_state.dart';

class EditPhotoCubit extends Cubit<EditPhotoState> {
  EditPhotoCubit(this.editProfileRepo) : super(EditPhotoInitial());
  final EditProfileRepo editProfileRepo;

  Future<void> editPhoto(File? image) async {
    emit(EditPhotoLoading());
    final res =
        await editProfileRepo.editPhoto(image);

    res.fold((failure) {
      emit(EditPhotoFailure(failure.errorMessage));
    }, (editProfile) {
      emit(EditPhotoSuccess(editProfile));
    });
  }
}
