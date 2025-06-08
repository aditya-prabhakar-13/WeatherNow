import 'package:flutter/material.dart';
import 'weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> cities = ['Delhi', 'Mumbai', 'Bengaluru', 'Kolkata', 'Chennai'];
  String? dropdownCity;

  final TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void navigateToWeather(String city) {
    if (city.isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WeatherScreen(city: city)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherNow'),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/WeatherNow_Background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Semi-transparent overlay
          Container(color: Colors.black.withOpacity(0.3)),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                // Text input for manual city entry
                TextField(
                  controller: _cityController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Enter city name',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () => navigateToWeather(_cityController.text.trim()),
                    ),
                  ),
                  onSubmitted: (value) => navigateToWeather(value.trim()),
                ),

                const SizedBox(height: 20),

                // Dropdown for selecting city
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: dropdownCity,
                    hint: const Text('Select a city'),
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: cities
                        .map((city) => DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          dropdownCity = value;
                        });
                        navigateToWeather(value);
                      }
                    },
                  ),
                ),

                const SizedBox(height: 30),

                // Major cities list
                const Text(
                  'Tap on a Major City:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                ...cities.map((city) => Card(
                      color: Colors.white.withOpacity(0.9),
                      child: ListTile(
                        title: Text(city),
                        onTap: () => navigateToWeather(city),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
