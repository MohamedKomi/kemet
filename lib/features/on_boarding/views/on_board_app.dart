import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/utils/app_router.dart';
import 'package:kemet/core/utils/assets.dart';
import 'package:kemet/core/utils/style.dart';
import 'package:kemet/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardApp extends StatelessWidget {
  const OnBoardApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AssetsService.logo),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              "on_board_app".tr(context)[0],
              style: Style.textThemeW700
                  .copyWith(fontSize: size.width * 0.079, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Text(
              "on_board_app".tr(context)[1],
              style: Style.textThemeW400
                  .copyWith(fontSize: size.width * 0.04, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            CustomButton(
                text:  "on_board_app".tr(context)[2],
                onPressed: () {
                  GoRouter.of(context).pushReplacement(AppRouter.home);
                })
          ],
        ),
      ),
    );
  }
}
