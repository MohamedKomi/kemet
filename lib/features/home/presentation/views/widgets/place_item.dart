import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/models/places_model/PlacesAfterTranslate.dart';
import 'white_part_in _places_item.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({super.key, required this.place, required this.iconButton});

  final PlacesAfterTranslate place;
  final Widget iconButton;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size.width * 0.06),
            topRight: Radius.circular(size.width * 0.06)),
      ),
      child: AspectRatio(
        aspectRatio: size.height * 0.8 / size.width * 0.85,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AspectRatio(
              aspectRatio: size.height * 0.8 / size.width * 0.85,
              child: CachedNetworkImage(
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
                fit: BoxFit.cover,
                imageUrl: place.images![0].secureUrl!,
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),
            WhitePartInItem(
              size: size,
              iconButton: iconButton,
              place: place,
            )
          ],
        ),
      ),
    );
  }
}
