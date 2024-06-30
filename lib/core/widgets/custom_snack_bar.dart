import 'package:flutter/material.dart';

void snackBar(String message, BuildContext ctx, Color textColor) {
  SnackBar snackBar = SnackBar(
    backgroundColor: const Color(0xff0D111F),
    content: Text(
      message,
      style: TextStyle(color: textColor, fontSize: 15),
      textAlign: TextAlign.center,
    ),
  );
  ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
}
