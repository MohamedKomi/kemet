import 'package:kemet/features/on_boarding/views/widgets/custom_on_boarding_container.dart';
import 'package:flutter/material.dart';

class CustomStack extends StatelessWidget {
  const CustomStack(
      {super.key,
      required this.image,
      required this.onPressed,
      required this.text,
      required this.desc});

  final String image;
  final Function() onPressed;
  final String text;
  final String desc;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image(
              image: AssetImage(image),
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            bottom: size.height * .08,
            right: size.width * .075,
            child: CustomOnBoardingContainer(
              text: text,
              desc: desc ,
              onPressed: onPressed,
            ),
          ),
        ],
    );
  }
}
