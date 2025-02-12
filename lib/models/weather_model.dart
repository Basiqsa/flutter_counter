class WeatherModel {
  final String cityName;
  final double temp;
  final String description;

  WeatherModel(
      {required this.cityName, required this.temp, required this.description});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temp: json['main']['temp'].toDouble(),
      description: json['weather'][0]['main'],
    );
  }
}
