import 'package:weather_in_mvvm_flutter/domain/repositories/weather_repositories.dart';

import '../entities/weather_model.dart';

class WeatherUsecases
{
  final WeatherRepositories weatherRepositories;

  WeatherUsecases({required this.weatherRepositories});

  Future<WeatherModel> getWeather(double lat, double lon) async{
    var temp=await weatherRepositories.getWeather(lat, lon);
    return temp;
  }

}