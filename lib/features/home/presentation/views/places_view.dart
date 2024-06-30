import 'package:kemet/constants.dart';
import 'package:kemet/core/utils/app_localization.dart';

import 'package:kemet/features/home/data/models/places_model/Places.dart';
import 'package:kemet/features/home/presentation/views/widgets/place_item.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class PlacesView extends StatelessWidget {
  const PlacesView({super.key, required this.places});

  final Places places;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home".tr(context)[4]),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: PlaceItem(
              place: places.placesAfterTranslate![index],
              iconButton: IconButton(
                onPressed: () async {
                  Uri url = Uri.parse(places.placesAfterTranslate![index].location!);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                icon: Icon(
                  Icons.location_on_outlined,
                  color: mainColor,
                ),
              ),
            ),
          );
        },
        itemCount: places.placesAfterTranslate!.length,
      ),
    );
  }
}
