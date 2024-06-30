import 'package:kemet/constants.dart';
import 'package:kemet/core/utils/app_router.dart';
import 'package:kemet/core/utils/assets.dart';
import 'package:kemet/core/utils/shared_data.dart';
import 'package:kemet/core/widgets/custom_button.dart';
import 'package:kemet/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_localization.dart';
import '../../../../core/utils/functions/drop_down_menu_item.dart';

class LangViewBody extends StatefulWidget {
  const LangViewBody({super.key, required this.onSetting});

  final bool? onSetting;

  @override
  State<LangViewBody> createState() => _LangViewBodyState();
}

class _LangViewBodyState extends State<LangViewBody> {
  String selectedLanguageCode = 'en';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.onSetting!) Image.asset(AssetsService.logo),
          SizedBox(
            height: height * 0.02,
          ),
          if (widget.onSetting!)
            Text(
              "splash".tr(context),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold),
            ),
          SizedBox(
            height: height * 0.03,
          ),
          SizedBox(
            height: height * .07,
            child: DropdownButtonFormField(
              menuMaxHeight: height * 0.3,
              value: SharedData.getUserLan()??selectedLanguageCode,
              decoration: InputDecoration(
                enabled: false,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              items: modelItemList(context),
              onChanged: (value) {
                widget.onSetting!?changeLang=false:changeLang=true;
                setState(() {
                  selectedLanguageCode = value as String;
                  SharedData.saveLan(lan: value);
                  AppLocalization.of(context)
                      ?.loadJsonLanguage(selectedLanguageCode);
                  LocaleManager.setLocale(
                      context, Locale(selectedLanguageCode));
                });
              },
            ),
          ),
          SizedBox(
            height: height * 0.08,
          ),
          CustomButton(
            text: widget.onSetting!
                ? 'button'.tr(context)['cont']
                : 'button'.tr(context)['done'],
            onPressed: () {
              SharedData.saveLan(lan: selectedLanguageCode);
              widget.onSetting!
                  ? GoRouter.of(context).push(AppRouter.onBoardingPage,
                      extra: selectedLanguageCode)
                  : GoRouter.of(context).go(AppRouter.home);
              // GoRouter.of(context).push(AppRouter.forgetPassPage,extra: false);
            },
          )
        ],
      ),
    );
  }
}
