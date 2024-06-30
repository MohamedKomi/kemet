import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:kemet/features/camera/data/video_repo/video_repo.dart';
import 'package:meta/meta.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit(this.videoRepo) : super(VideoInitial());
  final VideoRepo videoRepo;

  Future<void> fetchInfo(File? image, String lan) async {
    emit(InfoLoading());
    final res = await videoRepo.fetchInfo(image, lan);


    res.fold((failure) {
      emit(InfoFailure(failure.errorMessage));
    }, (info) {
      emit(InfoSuccess(info));
    });
  }
}
