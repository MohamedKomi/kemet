import 'package:kemet/core/utils/app_localization.dart';

import 'package:kemet/features/home/presentation/views/widgets/first_slider_widget.dart';
import 'package:kemet/features/home/presentation/views/widgets/second_slider_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/style.dart';
import 'posts_widget.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "home".tr(context)[1],
              style: Style.textThemeW700.copyWith(fontSize: size.height * .025),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * .01,
            ),
            const FirstSliderWidget(),
            SizedBox(
              height: size.height * .01,
            ),
            const SecondSliderWidget(),
            SizedBox(
              height: size.height * .02,
            ),
            const PostsWidget(),
          ],
        ),
      ),
    );
  }
}
