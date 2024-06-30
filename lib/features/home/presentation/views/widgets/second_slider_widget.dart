import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/features/home/presentation/manager/places_cubit/places_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/style.dart';
import '../../../data/models/places_model/PlacesAfterTranslate.dart';
import 'place_item.dart';

class SecondSliderWidget extends StatelessWidget {
  const SecondSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if(changeLang==true) {
      BlocProvider.of<PlacesCubit>(context).fetchPlaces();
      changeLang=false;
    }
    final size = MediaQuery.of(context).size;
    return BlocConsumer<PlacesCubit, PlacesState>(
      listener: (context, state) {},
      builder: (context, state) {

        if (state is PlacesSuccess) {
          List<PlacesAfterTranslate> places =
              state.places.placesAfterTranslate!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: size.width*0.03),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "home".tr(context)[2],
                        style: Style.textThemeW500
                            .copyWith(fontSize: size.height * .022),
                        textAlign: TextAlign.start,
                        maxLines: 2,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context)
                            .push(AppRouter.places, extra: state.places);
                      },
                      child: Text(
                        "home".tr(context)[3],
                        style: Style.textThemeW500.copyWith(color: mainColor),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .01,
              ),
              SizedBox(
                  height: size.height * 0.28,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(horizontal: size.width*0.03),
                        child: PlaceItem(
                            place: state.places.placesAfterTranslate![index],
                            iconButton: Container()),
                      );
                    },
                    itemCount: places.length,
                  )),
            ],
          );
        } else if (state is PlacesFailure) {
          return TextButton(
            onPressed: () {
              BlocProvider.of<PlacesCubit>(context).fetchPlaces();
            },
            child: Text(
              "try".tr(context),
            ),
          );
        } else {
          return SizedBox(
            height: size.height * 0.28,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
