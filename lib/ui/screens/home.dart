import 'package:flutter/material.dart';
import 'package:myapp/config/constants.dart';
import 'package:myapp/ui/components/data_row.dart';

import '../components/wind_direction_row.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTemp = 28;
  String currentCity = "Asuncion, Paraguay";
  String weatherDescription = "Soleado";
  int windSpeed = 12;
  double windDeg = 218;
  int st = 29;
  String wIcon = "10d";

  void _setData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset('lib/assets/ic-location.png',
                  width: 22, height: 22),
            ),
            Text(currentCity,
                style: const TextStyle(
                    fontSize: titleFontSize, color: Colors.white)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('lib/assets/weather_icons/$wIcon@2x.png'),
            Text(
              '$currentTemp°C',
              style:
                  const TextStyle(fontSize: tempFontSize, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(weatherDescription,
                  style: const TextStyle(
                      fontSize: dataFontSize, color: Colors.white)),
            ),
            dataRow("ic-temp.png", "Sensacion termica de $st°C"),
            windDirectionRow(windDeg, windSpeed),
            dataRow("ic-humidity.png", "Humedad: "),
          ],
        ),
      ),
    );
  }
}
