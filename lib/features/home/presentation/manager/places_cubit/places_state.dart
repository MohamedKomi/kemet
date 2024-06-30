part of 'places_cubit.dart';

@immutable
abstract class PlacesState {}

class PlacesInitial extends PlacesState {}
class PlacesLoading extends PlacesState {}
class PlacesSuccess extends PlacesState{
 final Places places;
  PlacesSuccess(this.places);
}
class PlacesFailure extends PlacesState{
  final String errorMessage;
  PlacesFailure(this.errorMessage);
}
