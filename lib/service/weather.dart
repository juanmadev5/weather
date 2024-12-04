import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:myapp/model/weather_data_model.dart';
import '../config/constants.dart';
import '../service/location.dart';

class WeatherService {
  WeatherData? data;
  Future<void> fetchWeatherData(BuildContext context) async {
    try {
      Position? position = await getCurrentLocation(context);
      if (position == null) {
        throw Exception("No se pudo obtener la ubicación.");
      }

      String url = baseUrl(position.latitude, position.longitude);

      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception(
            "HTTP ${response.statusCode}: ${response.reasonPhrase}");
      }

      final data = json.decode(response.body);
      this.data = WeatherData.fromJson(data);
    } catch (e) {
      throw Exception("Error al obtener datos del clima: $e");
    }
  }
}
