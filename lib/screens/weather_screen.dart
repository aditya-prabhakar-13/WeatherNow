import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  final String city;

  const WeatherScreen({Key? key, required this.city}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Map<String, dynamic>? weatherData;
  bool isLoading = true;
  String? errorMessage;

  final String apiKey = '4b1e5943bedc0ea53deef8c0017870f5';

  @override
  void initState() {
    super.initState();
    fetchWeather(widget.city);
  }

  Future<void> fetchWeather(String city) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          weatherData = data;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'City not found or API error';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to fetch weather data';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather in ${widget.city}'),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/weather_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay
          Container(
            color: Colors.black.withOpacity(0.4),
          ),

          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : errorMessage != null
                      ? Text(
                          errorMessage!,
                          style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )
                      : weatherData == null
                          ? const Text(
                              'No Data',
                              style: TextStyle(color: Colors.white),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  weatherData!['name'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${weatherData!['main']['temp'].toString()} °C',
                                  style: const TextStyle(
                                    fontSize: 48,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  weatherData!['weather'][0]['main'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _weatherInfo(
                                        icon: Icons.opacity,
                                        label: 'Humidity',
                                        value:
                                            '${weatherData!['main']['humidity']} %'),
                                    _weatherInfo(
                                        icon: Icons.air,
                                        label: 'Wind Speed',
                                        value:
                                            '${weatherData!['wind']['speed']} m/s'),
                                  ],
                                )
                              ],
                            ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _weatherInfo(
      {required IconData icon, required String label, required String value}) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}
