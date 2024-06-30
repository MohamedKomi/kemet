import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key, this.icon1, this.icon2, this.trailing, this.onTap, required this.text,
  });
  final  IconData? icon1;
  final  IconData? icon2;
  final Widget? trailing;
  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: size.width*0.01,horizontal:size.width*0.02 ),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(size.width*0.03),
        borderSide: BorderSide(width: size.width*0.002,color: Colors.grey),
      ),
      leading: Icon(
        icon1,
        size: size.width*0.08,
        color: mainColor,
      ),
      title:  Text(text),
      trailing: trailing??Icon(icon2,color: mainColor,),
      onTap: onTap??(){},
    );
  }
}
