import 'package:kemet/core/utils/app_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/style.dart';
import 'custom_camera_item.dart';

class CameraViewBody extends StatelessWidget {
  const CameraViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .15),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "camera".tr(context)['camera'],
              style: Style.textThemeW700
                  .copyWith(fontSize: MediaQuery.sizeOf(context).width * 0.045),
            ),
            CustomCameraItem(
              text: "camera".tr(context)['tourism'],
              onTap: 'first',
            ),
            CustomCameraItem(
                onTap: 'second', text: "camera".tr(context)['hieroglyphic'])
          ],
        ),
      ),
    );
  }
}
