import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/utils/assets.dart';
import 'package:flutter/material.dart';
import '../../../../../constants.dart';
import '../../../../../core/utils/style.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xfffafafa),
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: Image.asset(AssetsService.drawerIcon,width: MediaQuery.of(context).size.width*0.08),
      ),
      title:  Text(
        "home".tr(context)[0],
        style: Style.textThemeW700,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications,
            color: mainColor,
          ),
        ),
      ],
    );
  }
}
