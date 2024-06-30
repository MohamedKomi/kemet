import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/video_repo/video_repo.dart';
import 'explore_monuments_state.dart';

class ExploreMonumentsCubit extends Cubit<ExploreMonumentsState> {
  final VideoRepo videoRepo;

  ExploreMonumentsCubit(this.videoRepo) : super(ExploreMonumentsInitial());

  void fetchInformation(String name) async {
    emit(FetchMonumentLoading());
    final res = await videoRepo.fetchInfoMonument(name);

    res.fold((failure) {
      emit(FetchMonumentFailure(failure.errorMessage));
    }, (info) {
      emit(FetchMonumentSuccess(info));
    });
  }
}
