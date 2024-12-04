import 'package:flutter/material.dart';
import 'package:myapp/config/constants.dart';

Padding dataRow(String icon, String title) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Row(
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset('lib/assets/$icon', width: 24, height: 24)),
        Text(title,
            style: const TextStyle(fontSize: dataFontSize, color: Colors.white))
      ],
    ),
  );
}
