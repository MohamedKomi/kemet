import 'package:bloc/bloc.dart';
import 'package:kemet/features/home/data/models/posts_model/posts_model.dart';
import 'package:kemet/features/home/data/repos/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'likes_state.dart';

class LikesCubit extends Cubit<LikesState> {
  LikesCubit(this.homeRepo) : super(LikesInitial());
  final HomeRepo homeRepo;

  Future<void> likes(String postId, String status) async {
    final res = await homeRepo.fetchLikes(postId, status);
    res.fold((failure) {
      print(failure.errorMessage);
      emit(LikesFailure());
    }, (likes) {
      emit(LikesSuccess(likes));
    });
  }
}
