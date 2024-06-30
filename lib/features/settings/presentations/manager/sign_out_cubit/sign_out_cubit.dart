

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/edit_profile_repo.dart';


part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit(this.editProfileRepo) : super(SignOutInitial());
  final EditProfileRepo editProfileRepo;

  Future<void> signOut() async {
    emit(SignOutLoading());
    final res = await editProfileRepo.signOut();

    res.fold((failure) {
      emit(SignOutFailure(failure.errorMessage));
    }, (success) {
      emit(SignOutSuccess(success));
    });
  }
}
