import 'package:kemet/core/utils/style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.validator,
    this.helperText,
    this.enable,
    this.widget,
    this.lines,
  }) : super(key: key);
  final String? hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String? val) validator;
  final String? helperText;
  final bool? enable;
  final Widget? widget;
  final int? lines;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return TextFormField(
      maxLines: lines ?? 1,
      enabled: enable ?? true,
      validator: validator,
      keyboardType: keyboardType,
      controller: controller,
      style: const TextStyle(fontSize: 18),
      decoration: InputDecoration(
        helperText: helperText,
        helperStyle:
            Style.textThemeW400.copyWith(fontSize: size.height * 0.013),
        hintText: hintText ?? '',
        hintStyle: Style.textThemeW400.copyWith(fontSize: size.height * 0.015),
        suffixIcon: widget,
        errorMaxLines: 3,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(size.width * 0.04),
          borderSide: BorderSide(width: size.width * 0.009),
        ),
      ),
    );
  }
}
