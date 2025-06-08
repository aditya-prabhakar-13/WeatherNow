import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = '4b1e5943bedc0ea53deef8c0017870f5';
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  static Future<Map<String, dynamic>> getWeather(String city) async {
    final url = Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
