import 'package:flutter/material.dart';

class CityTile extends StatelessWidget {
  final String cityName;
  final VoidCallback onTap;

  CityTile({required this.cityName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          cityName,
          style: TextStyle(fontSize: 20),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
