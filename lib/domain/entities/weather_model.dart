import '../../data/models/weather_response.dart';

class WeatherModel{
  final double latitude;
  final double longitude;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int groundLevel;
  final int seaLevel;
  final double windSpeed;
  final int windDeg;
  final double windGust;
  final int cloudsAll;
  final DateTime sunrise;
  final DateTime sunset;
  final String dateTime;
  final String name;
  final int timeZone;
  final int visibility;


  WeatherModel(this.latitude, this.longitude, this.weatherMain,
      this.weatherDescription, this.weatherIcon, this.temp, this.feelsLike,
      this.tempMin, this.tempMax, this.pressure, this.humidity,
      this.groundLevel, this.seaLevel, this.windSpeed, this.windDeg,
      this.windGust, this.cloudsAll, this.sunrise, this.sunset, this.dateTime,this.name,this.timeZone, this.visibility);
}