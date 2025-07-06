import 'package:dio/dio.dart';
import 'package:weather_in_mvvm_flutter/data/models/weather_response.dart';


class RemoteWeatherDataSource
{
  final Dio dio;

  RemoteWeatherDataSource(this.dio);

  Future<WeatherResponse> fetchWeather(double lat, double lon) async {
    final response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: {
        'appid': 'c15646613c5b5b7a89f764b00b96c709',
        'lat': lat,
        'lon': lon,
      },
    );

    var temp = WeatherResponse.fromJson(response.data);

    return temp;
  }


}