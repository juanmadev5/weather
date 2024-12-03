import 'package:flutter/material.dart';
import 'package:myapp/config/constants.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: splashScreenBgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/ic-weather.png', width: 96, height: 96),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Weather App",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
