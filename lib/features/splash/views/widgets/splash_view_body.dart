import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:kemet/core/utils/assets.dart';
import 'package:kemet/core/utils/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_router.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: Image.asset(
            AssetsService.splash,
            fit: BoxFit.cover,
          ),
        ),
        DefaultTextStyle(
          style: GoogleFonts.akronim(
            textStyle: const TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.w400,
                color: Color(0xffd8ae2e)),
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText('KEMET'),
            ],
            isRepeatingAnimation: true,
          ),
        )
      ],
    );
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(milliseconds: 3500),
      () async {
        bool? first = SharedData.getFirst();
        String? token = SharedData.getToken();

        if (first != false) {
          GoRouter.of(context).go(AppRouter.langPage, extra: true);
        } else {
          if (token == null) {
            GoRouter.of(context).go(
              AppRouter.loginPage,
            );
          } else {
            GoRouter.of(context).go(AppRouter.home);
          }
        }
      },
    );
  }
}
