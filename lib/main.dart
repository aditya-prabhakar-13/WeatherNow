import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(WeatherNowApp());
}

class WeatherNowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherNow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}