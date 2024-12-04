class WeatherData {
  final int currentTemp;
  final String currentCity;
  final String weatherDescription;
  final int windSpeed;
  final double windDeg;
  final int feelsLikeTemp;
  final String weatherIcon;
  final int humidity;
  final double visibility;
  final int maxTemp;

  WeatherData({
    required this.currentTemp,
    required this.currentCity,
    required this.weatherDescription,
    required this.windSpeed,
    required this.windDeg,
    required this.feelsLikeTemp,
    required this.weatherIcon,
    required this.humidity,
    required this.visibility,
    required this.maxTemp,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      currentTemp: (json['main']['temp'] as num).toInt(),
      currentCity: json['name'] as String,
      weatherDescription: json['weather'][0]['description'] as String,
      windSpeed: (json['wind']['speed'] as num).toInt(),
      windDeg: (json['wind']['deg'] as num).toDouble(),
      feelsLikeTemp: (json['main']['feels_like'] as num).toInt(),
      weatherIcon: json['weather'][0]['icon'] as String,
      humidity: (json['main']['humidity'] as num).toInt(),
      visibility: (json['visibility'] as num).toDouble(),
      maxTemp: (json['main']['temp_max'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'main': {
        'temp': currentTemp,
        'feels_like': feelsLikeTemp,
        'humidity': humidity,
        'temp_max': maxTemp,
      },
      'name': currentCity,
      'weather': [
        {
          'description': weatherDescription,
          'icon': weatherIcon,
        }
      ],
      'wind': {
        'speed': windSpeed,
        'deg': windDeg,
      },
      'visibility': visibility,
    };
  }
}
