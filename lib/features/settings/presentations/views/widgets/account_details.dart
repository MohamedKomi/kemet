import 'package:kemet/core/utils/shared_data.dart';
import 'package:kemet/core/utils/style.dart';
import 'package:flutter/material.dart';

class AccountDetailsSetting extends StatelessWidget {
  const AccountDetailsSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(SharedData.getUserImage()!),
          radius: size.width * 0.1,
        ),
        SizedBox(
          width: size.width * 0.05,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              SharedData.getUserName()!,
              style: Style.textThemeW700,
            ),
            Text(
              SharedData.getUserEmail()!,
              style: Style.textThemeW700,
            ),
          ],
        ),
      ],
    );
  }
}
