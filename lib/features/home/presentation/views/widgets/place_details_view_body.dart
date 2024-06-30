import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/models/places_model/PlacesAfterTranslate.dart';

class PlaceDetailsViewBody extends StatelessWidget {
  const PlaceDetailsViewBody({super.key, required this.place});

  final PlacesAfterTranslate place;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CachedNetworkImage(
              width: double.infinity,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: const Color(0xfffef9d8),
                highlightColor: const Color(0xffd8ae2e),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              fit: BoxFit.fill,
              imageUrl: place.images![0].secureUrl!,
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(place.desc!),
          ],
        ),
      ),
    );
  }
}
