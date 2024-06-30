import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/utils/app_router.dart';
import 'package:kemet/core/utils/assets.dart';
import 'package:kemet/core/utils/shared_data.dart';
import 'package:kemet/features/on_boarding/views/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingBody extends StatefulWidget {
  const OnBoardingBody({super.key});

  @override
  State<OnBoardingBody> createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  int _activePage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final pages = [
      CustomStack(
        image: AssetsService.onBoard1,
        onPressed: () {
          _pageController.animateToPage(1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
        },
        text: "onboard1".tr(context)[0],
        desc: "onboard1".tr(context)[1],
      ),
      CustomStack(
        image: AssetsService.onBoard2,
        onPressed: () {
          _pageController.animateToPage(2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
        },
        text: "onboard2".tr(context)[0],
        desc: "onboard2".tr(context)[1],
      ),
      CustomStack(
        image: AssetsService.onBoard3,
        onPressed: () {
          GoRouter.of(context).push(AppRouter.loginPage);
          SharedData.saveFirst(first: false);
        },
        text: "onboard3".tr(context)[0],
        desc: "onboard3".tr(context)[1],
      ),
    ];
    return Stack(
      children: [
        PageView.builder(
          physics: const BouncingScrollPhysics(),
          controller: _pageController,
          onPageChanged: (int page) {
            setState(
              () {
                _activePage = page;
              },
            );
          },
          itemCount: pages.length,
          itemBuilder: (BuildContext context, int index) {
            return pages[index % pages.length];
          },
        ),
        Positioned(
          bottom: size.height * 0.05,
          right: size.width * 0.45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
              pages.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.005),
                child: Container(
                  height: 10,
                  width: _activePage == index
                      ? size.width * 0.06
                      : size.width * 0.02,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xffd8ae2e), Color(0xfffef9d8)]),
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.width * 0.02)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
