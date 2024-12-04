import 'package:flutter/material.dart';
import 'package:myapp/config/constants.dart';
import 'package:myapp/utils/wind_direction.dart';
import 'dart:math';

Padding windDirectionRow(double windDeg, int windSpeed) {
  double adjustedDeg = (windDeg + 180) % 360;
  double radianes = adjustedDeg * (pi / 180);

  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Transform.rotate(
              angle: radianes, // Usar radianes aquí
              child: Image.asset('lib/assets/ic-wind-dir.png', width: 32)),
        ),
        Text("${windDirection(windDeg)}, $windSpeed km/h",
            style: const TextStyle(fontSize: dataFontSize, color: Colors.white))
      ],
    ),
  );
}
