

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../home/data/models/posts_model/posts_model.dart';
import '../../../data/repos/profile_repo.dart';

part 'profile_post_state.dart';

class ProfileCubit extends Cubit<ProfilePostState> {
  final ProfileRepo profileRepo;
  ProfileCubit(this.profileRepo) : super(ProfilePostInitial());
  Future<void> fetchUserPosts() async {
    emit(ProfilePostLoading());
    final res = await profileRepo.fetchUserPosts();

    res.fold((failure) {
      emit(ProfilePostFailure(failure.errorMessage));
    }, (posts) {
      emit(ProfilePostSuccess(posts));
    });
  }
  Future<void> deleteUserPosts(String id) async {
    await profileRepo.deleteUserPosts(id);
    fetchUserPosts();
  }

}
