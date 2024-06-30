import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/utils/style.dart';
import 'package:flutter/material.dart';

class Helps extends StatelessWidget {
  const Helps({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("helps".tr(context)[0],
            style: Style.textThemeW600.copyWith(fontSize: size.width * 0.04)),
        centerTitle: true,
        backgroundColor: const Color(0xfffafafa),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.08),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("helps".tr(context)[1],
                  style:
                      Style.textThemeW500.copyWith(fontSize: size.width * 0.043)),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                "helps".tr(context)[2],
                style: Style.textThemeW300.copyWith(fontSize: size.width * 0.037),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text("helps".tr(context)[3],
                  style:
                  Style.textThemeW500.copyWith(fontSize: size.width * 0.043)),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                "helps".tr(context)[4],
                style: Style.textThemeW300.copyWith(fontSize: size.width * 0.037),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
