part of 'likes_cubit.dart';

@immutable
abstract class LikesState {}

class LikesInitial extends LikesState {}
class LikesFailure extends LikesState {}
class LikesSuccess extends LikesState {
  final LikesModel likesModel;

  LikesSuccess(this.likesModel);
}
