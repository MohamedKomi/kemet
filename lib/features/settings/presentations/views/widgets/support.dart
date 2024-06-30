import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/utils/assets.dart';
import 'package:kemet/core/utils/style.dart';
import 'package:kemet/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('support'.tr(context)[0],style: Style.textThemeW600.copyWith(fontSize: size.width * 0.04)),
        centerTitle: true,
        backgroundColor: const Color(0xfffafafa),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.08),
        child: Column(
          children: [
            Image.asset(AssetsService.logo),
            SizedBox(
              height: size.height * 0.1,
            ),
            Text('support'.tr(context)[1],
                style:
                    Style.textThemeW500.copyWith(fontSize: size.width * 0.043)),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              'support'.tr(context)[2],
              textAlign: TextAlign.center,
              style: Style.textThemeW300.copyWith(fontSize: size.width * 0.037),
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            CustomButton(text: 'support'.tr(context)[3], onPressed: (){})
          ],
        ),
      ),
    );
  }
}
