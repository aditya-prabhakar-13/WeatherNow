import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weathernow/main.dart';

void main() {
  testWidgets('WeatherNow app smoke test', (WidgetTester tester) async {
    // Build the WeatherNow app and trigger a frame.
    await tester.pumpWidget(WeatherNowApp());

    // Verify that HomeScreen loads with expected widgets.
    expect(find.text('WeatherNow'), findsOneWidget);
    expect(find.text('Enter city name'), findsOneWidget);
    expect(find.text('Select a city:'), findsOneWidget);
    expect(find.text('Major Cities:'), findsOneWidget);
  });
}

