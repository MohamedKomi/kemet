import 'package:flutter/material.dart';

import 'widgets/on_boarding_body.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body:OnBoardingBody(),
    );
  }
}
