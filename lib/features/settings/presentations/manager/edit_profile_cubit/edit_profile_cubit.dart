import 'package:kemet/features/settings/data/models/edit_profile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/edit_profile_repo.dart';


part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.editProfileRepo) : super(EditProfileInitial());
  final EditProfileRepo editProfileRepo;

  Future<void> editProfile(
      String firstName, String lastName, int age, String phone) async {
    emit(EditProfileLoading());
    final res =
        await editProfileRepo.editProfile(firstName, lastName, age, phone);

    res.fold((failure) {
      emit(EditProfileFailure(failure.errorMessage));
    }, (editProfile) {
      emit(EditProfileSuccess(editProfile));
    });
  }
}
