import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/config/constants.dart';
import 'package:myapp/service/location.dart';
import 'package:myapp/states.dart';
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
  STATES state = STATES.loading;
  String eMessage = "";
  int currentTemp = 0;
  String currentCity = "";
  String weatherDescription = "";
  int windSpeed = 0;
  double windDeg = 0;
  int st = 0;
  String wIcon = "";
  int humidity = 0;
  double uvi = 0;
  double visibility = 0;
  int maxTemp = 0;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    setState(() => state = STATES.loading);

    try {
      Position? position = await getCurrentLocation(context);
      if (position == null) {
        setState(() {
          eMessage = "No se pudo obtener la posición.";
        });
        throw Exception("No se pudo obtener la ubicación");
      }

      String url = baseUrl(position.latitude, position.longitude);

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          state = STATES.ok;
          currentTemp = (data['main']['temp'] as num).toInt();
          currentCity = data['name'];
          weatherDescription = data['weather'][0]['description'];
          windSpeed = (data['wind']['speed'] as num).toInt();
          windDeg = (data['wind']['deg'] as num).toDouble();
          st = (data['main']['feels_like'] as num).toInt();
          wIcon = data['weather'][0]['icon'];
          humidity = (data['main']['humidity'] as num).toInt();
          visibility = (data['visibility'] as num).toDouble();
          maxTemp = (data['main']['temp_max'] as num).toInt();
        });
      } else {
        setState(() {
          eMessage = "HTTP ${response.statusCode}: ${response.reasonPhrase}";
        });
        throw Exception(
            "HTTP ${response.statusCode}: ${response.reasonPhrase}");
      }
    } catch (e) {
      setState(() {
        state = STATES.error;
        eMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 162, 209),
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      toolbarHeight: 120.0,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(
            top: 32.0, right: 16.0, left: 16.0, bottom: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 14.0, left: 4.0),
                  child: Image.asset('lib/assets/ic-location.png',
                      width: 22, height: 22),
                ),
                Text(
                  currentCity,
                  style: const TextStyle(
                      fontSize: titleFontSize, color: Colors.white),
                ),
              ],
            ),
            windDirectionRow(windDeg, windSpeed),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (state) {
      case STATES.loading:
        return const Center(child: CircularProgressIndicator());
      case STATES.ok:
        return _buildForecast();
      case STATES.error:
        return _buildError(eMessage);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildError(String eMessage) {
    return Center(
      child: Text(
        "Error al cargar los datos. Intente nuevamente. $eMessage",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildForecast() {
    return RefreshIndicator(
      onRefresh: fetchWeatherData,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Image.asset(
                'lib/assets/weather_icons/${wIcon.substring(0, wIcon.length - 1)}.png',
                height: 164.0),
            Text(
              '$currentTemp°C',
              style:
                  const TextStyle(fontSize: tempFontSize, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Máxima: $maxTemp°C',
                style: const TextStyle(
                    fontSize: dataFontSize, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
              child: Text(
                weatherDescription,
                style: const TextStyle(
                    fontSize: dataFontSize, color: Colors.white),
              ),
            ),
            dataRow("ic-temp.png", "Sensación térmica de $st°C"),
            dataRow("ic-humidity.png", "Humedad: $humidity%"),
            dataRow("ic-uv-index.png", "Índice UV: ${uvi.toInt()}"),
            dataRow("ic-visibility.png",
                "Visibilidad: ${(visibility / 1000).toInt()} km"),
          ],
        ),
      ),
    );
  }
}
