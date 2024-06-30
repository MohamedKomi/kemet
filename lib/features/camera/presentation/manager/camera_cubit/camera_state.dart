part of 'camera_cubit.dart';

@immutable
abstract class CameraState {}

class CameraInitial extends CameraState {}

class CameraLoading extends CameraState {}

class CameraSuccess extends CameraState {
  final String message;

  CameraSuccess(this.message);
}

class CameraFailure extends CameraState {
  final String message;

  CameraFailure(this.message);
}
