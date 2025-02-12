import 'dart:convert';
import 'package:flutter_counter/constants/constants.dart';
import 'package:flutter_counter/models/weather_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

final weatherServiceProvider = Provider<WeatherService>((ref) => WeatherService(
      apiKey: weatherApi,
    ));

final weatherServicesFutureProvider = FutureProvider<WeatherModel>((ref) async {
  final weatherService = ref.watch(weatherServiceProvider);
  try {
    final city = await weatherService.getCurrentLocation();
    return weatherService.getWeather(city);
  } catch (e) {
    throw Exception(e);
  }
});

class WeatherService {
  final apiKey;
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  WeatherService({required this.apiKey});

//Getcurrentlocation METHOD RETURNS A STRING VALUE OF THE CITY
  Future<String> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }

//Getting current location
    Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
    ));

//Converting position to city using Geocoding
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

//Getting City name from the first placemark
    String? city = placemarks[0].locality;

    return city ?? '';
  }

//getWeather METHOD RETURNS A WEATHER MODEL OBJECT WHICH CONTAINS THE WEATHER DATA OF THE CITY
  Future<WeatherModel> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data: ${response.body}');
    }
  }
}
