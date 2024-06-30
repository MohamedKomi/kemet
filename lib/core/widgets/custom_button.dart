import 'package:kemet/core/utils/style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    this.width,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Function() onPressed;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: (size.height * 0.0603).floorToDouble(),
        width: width ?? (size.width * .88).floorToDouble(),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xffd8ae2e), Color(0xfffef9d8)]),
          borderRadius: BorderRadius.all(Radius.circular(size.width * 0.04)),
        ),
        child: Center(
          child: Text(
            text,
            style: Style.textThemeW500.copyWith(
              fontSize: size.height * 0.02,
            ),
          ),
        ),
      ),
    );
  }
}
