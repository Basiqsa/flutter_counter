import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_counter/models/weather_model.dart';
import 'package:flutter_counter/service/weather_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsyncValue = ref.watch(weatherServicesFutureProvider);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 202, 113, 61),
          centerTitle: true,
          title: const Text('Flutter Weather Page'),
        ),
        body: weatherAsyncValue.when(
            data: (weather) => buildWeatherContent(context, weather),
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}

Widget buildWeatherContent(BuildContext context, WeatherModel weather) {
  return Stack(children: [
    ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 9, sigmaY: 100.0),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 202, 113, 61)),
          ),
          Expanded(
            child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 254, 166, 83)),
            ),
          ),
          Expanded(
            child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 202, 113, 61)),
            ),
          ),
        ],
      ),
    ),
    Column(
      mainAxisSize: MainAxisSize.min,
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(32),
          child: Text('Hello World',
              style: TextStyle(color: Colors.white, fontSize: 36)),
        ),
        Center(child: Lottie.asset('assets/lottie/Rainy.json')),
        Center(
          child: Text(weather.cityName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              )),
        ),
        Center(
          child: Text('${weather.temp.round()} °C',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              )),
        ),
        Center(
          child: Text(weather.description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              )),
        ),
      ],
    )
  ]);
}
