import 'package:flutter/material.dart';
import 'package:myapp/config/constants.dart';
import 'package:myapp/main.dart';
import 'package:myapp/model/weather_data_model.dart';
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
  STATES state = STATES.ok;
  String eMessage = "";
  WeatherData? weatherData = gData!.data;

  Future<void> _fetchWeatherData() async {
    setState(() => state = STATES.loading);

    try {
      await gData!.fetchWeatherData(context);
      final data = gData!.data;

      setState(() {
        state = STATES.ok;
        weatherData = data;
      });
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
        child: weatherData != null
            ? Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 14.0, left: 4.0),
                        child: Image.asset('lib/assets/ic-location.png',
                            width: 22, height: 22),
                      ),
                      Text(
                        weatherData!.currentCity,
                        style: const TextStyle(
                            fontSize: titleFontSize, color: Colors.white),
                      ),
                    ],
                  ),
                  windDirectionRow(
                      weatherData!.windDeg, weatherData!.windSpeed),
                ],
              )
            : const SizedBox.shrink(),
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
    if (weatherData == null) {
      return const SizedBox.shrink();
    }

    return RefreshIndicator(
      onRefresh: _fetchWeatherData,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Image.asset(
                'lib/assets/weather_icons/${weatherData!.weatherIcon.substring(0, weatherData!.weatherIcon.length - 1)}.png',
                height: 164.0),
            Text(
              '${weatherData!.currentTemp}°C',
              style:
                  const TextStyle(fontSize: tempFontSize, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Máxima: ${weatherData!.maxTemp}°C',
                style: const TextStyle(
                    fontSize: dataFontSize, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
              child: Text(
                weatherData!.weatherDescription,
                style: const TextStyle(
                    fontSize: dataFontSize, color: Colors.white),
              ),
            ),
            dataRow("ic-temp.png",
                "Sensación térmica de ${weatherData!.feelsLikeTemp}°C"),
            dataRow("ic-humidity.png", "Humedad: ${weatherData!.humidity}%"),
            dataRow("ic-visibility.png",
                "Visibilidad: ${(weatherData!.visibility / 1000).toInt()} km"),
          ],
        ),
      ),
    );
  }
}
