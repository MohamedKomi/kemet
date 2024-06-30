part of 'video_cubit.dart';

@immutable
abstract class VideoState {}

class VideoInitial extends VideoState {}

class InfoLoading extends VideoState {}

class InfoSuccess extends VideoState {
  final Map<String, dynamic> info;

  InfoSuccess(this.info);
}

class InfoFailure extends VideoState {
  final String message;

  InfoFailure(this.message);
}
