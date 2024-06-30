import 'package:bloc/bloc.dart';
import 'package:kemet/features/home/data/repos/home_repo.dart';
import 'package:meta/meta.dart';

import '../../../data/models/places_model/Places.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit(this.homeRepo) : super(PlacesInitial());
  final HomeRepo homeRepo;

  Future<void> fetchPlaces() async {
    emit(PlacesLoading());
    final res = await homeRepo.fetchPlaces();

    res.fold((failure) {
      emit(PlacesFailure(failure.errorMessage));
    }, (places) {
      emit(PlacesSuccess(places));
    });
  }
}
