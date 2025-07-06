import 'package:intl/intl.dart';
import 'package:weather_in_mvvm_flutter/domain/entities/weather_model.dart';
import 'package:weather_in_mvvm_flutter/domain/repositories/weather_repositories.dart';

import '../datasources/remote_weather_datasource.dart';

class WeatherRepositoryImp extends WeatherRepositories {
  final RemoteWeatherDataSource remoteWeatherDataSource;

  WeatherRepositoryImp({required this.remoteWeatherDataSource});

  @override
  Future<WeatherModel> getWeather(double lat, double lon) async {
    final response = await remoteWeatherDataSource.fetchWeather(lat, lon);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMMM yyyy').format(now);

    return WeatherModel(
      response.coord.lat,
      response.coord.lon,
      response.weather[0].main,
      response.weather[0].description,
      response.weather[0].icon,
      response.main.temp,
      response.main.feels_like,
      response.main.temp_min,
      response.main.temp_max,
      response.main.pressure,
      response.main.humidity,
      response.main.grnd_level,
      response.main.sea_level,
      response.wind.speed,
      response.wind.deg,
      response.wind.gust,
      response.clouds.all,
      _convertUtcToLocalTime(response.sys.sunrise,response.timezone),
      _convertUtcToLocalTime(response.sys.sunset,response.timezone),
      formattedDate,
      response.name,
      response.timezone,
      response.visibility
    );
  }

  DateTime _convertUtcToLocalTime(int utcTimestamp, int timezoneOffsetInSeconds) {
    final utcTime = DateTime.fromMillisecondsSinceEpoch(utcTimestamp * 1000, isUtc: true);
    return utcTime.add(Duration(seconds: timezoneOffsetInSeconds));
  }


}
