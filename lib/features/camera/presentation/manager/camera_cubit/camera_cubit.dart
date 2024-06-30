import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:kemet/features/camera/data/camera_repo/camera_repo.dart';
import 'package:meta/meta.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit(this.cameraRepo) : super(CameraInitial());
  final CameraRepo cameraRepo;

  Future<void> fetchPhoto(File? image) async {
    emit(CameraLoading());
    final res = await cameraRepo.fetchPhoto(image);

    res.fold((failure) {
      emit(CameraFailure(failure.errorMessage));
    }, (photo) {
      emit(CameraSuccess(photo.toString()));
    });
  }
}
