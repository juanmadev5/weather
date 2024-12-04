import 'package:flutter/material.dart';
import 'package:myapp/config/constants.dart';
import 'package:myapp/service/weather.dart';
import 'package:myapp/ui/screens/home.dart';
import 'package:myapp/ui/screens/splash.dart';

void main() {
  runApp(const MyApp());
}

WeatherService? gData;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _fetchAndNavigate();
  }

  void _fetchAndNavigate() async {
    try {
      gData = WeatherService();
      await gData!.fetchWeatherData(context);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text("No se pudo obtener el clima: $e"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Intentar de nuevo'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Splash(),
      ),
    );
  }
}
