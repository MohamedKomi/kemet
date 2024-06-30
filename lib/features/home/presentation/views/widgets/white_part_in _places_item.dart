import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/features/home/data/models/places_model/PlacesAfterTranslate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/style.dart';

class WhitePartInItem extends StatelessWidget {
  const WhitePartInItem({
    super.key,
    required this.size,
    required this.iconButton,
    required this.place,
  });

  final Size size;
  final PlacesAfterTranslate place;
  final Widget iconButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    place.placeName!.replaceAll(':', ''),
                    overflow: TextOverflow.ellipsis,
                    style: Style.textThemeW700
                        .copyWith(fontSize: size.height * .02),
                  ),
                ),
                RatingBar.builder(
                  itemSize: size.height * .025,
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star_border_purple500_outlined,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconButton,
                TextButton(
                    onPressed: () {
                      GoRouter.of(context)
                          .push(AppRouter.placeDetails, extra: place);
                    },
                    child: Text(
                      "read".tr(context),
                      style: Style.textThemeW700,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
