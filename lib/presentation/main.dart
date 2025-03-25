import 'package:flutter/material.dart';
import 'package:weather_app/presentation/weather_for_location/view/location_main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LocationScreen(),
      ),
    );
  }
}
