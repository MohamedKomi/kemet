import 'package:flutter/material.dart';

import '../../data/models/places_model/PlacesAfterTranslate.dart';
import 'widgets/place_details_view_body.dart';

class PlaceDetailsView extends StatelessWidget {
  const PlaceDetailsView({super.key, required this.place});

  final PlacesAfterTranslate place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.placeName!.replaceAll(':', '')),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: PlaceDetailsViewBody(place: place,)
    );
  }
}
