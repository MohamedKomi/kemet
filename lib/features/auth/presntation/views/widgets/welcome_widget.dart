import 'package:flutter/material.dart';

import '../../../../../core/utils/app_localization.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/style.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: size.height * 0.08,
        ),
        Image.asset(AssetsService.logo, width: size.width * 0.7),
        Text("welcome".tr(context)[0],
            style: Style.textThemeW600.copyWith(fontSize: size.width * 0.07),
            textAlign: TextAlign.center),
        Text(
          "welcome".tr(context)[1],
          style: Style.textThemeW400.copyWith(fontSize: size.width * 0.03),
        )
      ],
    );
  }
}
