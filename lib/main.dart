import 'package:flutter/material.dart';
import 'package:flutter_counter/pages/counter_page.dart';
import 'package:flutter_counter/pages/weather_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: FlutterCounterApp()));
}

class FlutterCounterApp extends StatelessWidget {
  const FlutterCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageView(
        children: const [
          CouterPage(),
          WeatherPage(),
        ],
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
