import 'package:weather_in_mvvm_flutter/domain/entities/weather_model.dart';

abstract class WeatherRepositories{
  Future<WeatherModel> getWeather(double lat, double lon);
}