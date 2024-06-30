import 'package:flutter/material.dart';

import '../../../constants.dart';

List<DropdownMenuItem<String>>? modelItemList(context) {
  List<DropdownMenuItem<String>>? modelItems = language.entries
      .map<DropdownMenuItem<String>>(
        (entry) => DropdownMenuItem<String>(
          value: entry.value,
          child: Text(
            entry.key,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      )
      .toList();
  return modelItems;
}
