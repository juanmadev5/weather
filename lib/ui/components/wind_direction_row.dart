import 'package:flutter/material.dart';
import 'package:myapp/config/constants.dart';
import 'package:myapp/utils/wind_direction.dart';

Row windDirectionRow(double windDeg, int windSpeed) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Transform.rotate(
            angle: windDeg,
            child: Image.asset('lib/assets/ic-wind-dir.png',
                width: 32, height: 32)),
      ),
      Text("${windDirection(windDeg)}, $windSpeed km/h",
          style: const TextStyle(fontSize: dataFontSize, color: Colors.white))
    ],
  );
}
