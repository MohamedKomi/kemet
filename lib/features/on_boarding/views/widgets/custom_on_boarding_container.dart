import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/utils/style.dart';
import 'package:kemet/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CustomOnBoardingContainer extends StatelessWidget {
  final String text;
  final String desc;
  final Function() onPressed;

  const CustomOnBoardingContainer(
      {super.key,
      required this.text,
      required this.desc,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(size.width * 0.07),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      //height: size.height * .39,
      width: size.width * .85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: Style.textThemeW600.copyWith(
              fontSize: size.height * .04,
            ),
          ),
          Text(
            desc,
            style: TextStyle(
              fontSize: size.height * 0.022,
            ),
          ),
          SizedBox(height: size.height*.01,),
          CustomButton(
            text: 'button'.tr(context)['next'],
            onPressed: onPressed,
            width: (size.width * 0.72).floorToDouble(),
          )
        ],
      ),
    );
  }
}
