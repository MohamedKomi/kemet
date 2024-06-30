import 'package:bloc/bloc.dart';
import 'package:kemet/features/home/data/models/posts_model/posts_model.dart';
import 'package:meta/meta.dart';

import '../../../data/repos/home_repo.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this.homeRepo) : super(PostsInitial());
  final HomeRepo homeRepo;

  Future<void> fetchPosts() async {
    emit(PostsLoading());
    final res = await homeRepo.fetchPssts();

    res.fold((failure) {
      emit(PostsFailure(failure.errorMessage));
    }, (posts) {
      emit(PostsSuccess(posts));
    });
  }
}
