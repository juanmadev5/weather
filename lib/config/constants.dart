import 'dart:ui';

const apiKey = "05b8aec48d1e5dc66398472e7c9aaa21";

String baseUrl(double lat, double lon) {
  return "https://api.openweathermap.org/data/3.0/onecall?lat=${lat}&lon=${lon}&lang=es&appid=${apiKey}";
}

// from UI
const splashScreenBgColor = Color.fromARGB(211, 1, 35, 49);
const mainColor = Color.fromARGB(255, 4, 75, 105);
const double tempFontSize = 64;
const double titleFontSize = 20;
const double dataFontSize = 18;
