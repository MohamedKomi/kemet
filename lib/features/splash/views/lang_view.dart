import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/features/splash/views/widgets/lang_view_body.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/style.dart';

class LangView extends StatelessWidget {
  const LangView({super.key, required this.onSetting});

  final bool? onSetting;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: onSetting! ? Colors.black : const Color(0xfffafafa),
      appBar: !onSetting!
          ? AppBar(
              title: Text("acc_screen".tr(context)[2],
                  style: Style.textThemeW600
                      .copyWith(fontSize: size.width * 0.04)),
              backgroundColor: const Color(0xfffafafa),
              centerTitle: true,
              elevation: 0,
            )
          : null,
      body: LangViewBody(
        onSetting: onSetting!,
      ),
    );
  }
}
