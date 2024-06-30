import 'package:kemet/features/camera/data/info_monument_model/info_monument_model.dart';

abstract class ExploreMonumentsState {}

class ExploreMonumentsInitial extends ExploreMonumentsState {}

class FetchMonumentLoading extends ExploreMonumentsState {}

class FetchMonumentSuccess extends ExploreMonumentsState {
  final MonumentTranslation info;

  FetchMonumentSuccess(this.info);
}

class FetchMonumentFailure extends ExploreMonumentsState {
  final String errorMessage;

  FetchMonumentFailure(this.errorMessage);
}
