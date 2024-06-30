import 'package:carousel_slider/carousel_slider.dart';
import 'package:kemet/constants.dart';
import 'package:kemet/core/utils/assets.dart';
import 'package:kemet/core/utils/style.dart';
import 'package:flutter/material.dart';

class FirstSliderWidget extends StatelessWidget {
  const FirstSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CarouselSlider(
      options: CarouselOptions(
        height: size.height * .2,
        viewportFraction: 0.6,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
      ),
      items: AssetsService.sliderImages
          .map(
            (item) => Container(
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 10, color: mainColor)]),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: AspectRatio(
                      aspectRatio: size.height / size.width * .7,
                      child: Image.asset(
                        item['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: size.width * .012,
                    bottom: size.height * .012,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * .007),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(.5)),
                      child: Text(
                        item['name'],
                        style: Style.textThemeW700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
