
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/weather_model.dart';
import '../../domain/usecase/get_weather_usercases.dart';
import 'LocationViewModel.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherUsecases _useCase;
  late LocationViewModel _locationViewModel;

  WeatherModel? _weather;
  String? _error;
  bool _loading = false;
  WeatherModel? get weather => _weather;
  String? get error => _error;
  bool get isLoading => _loading;

  String? get SunsetTime {
    return formatTime(_weather!.sunset);
  }

  String? ConvertTemp(double temp, String unit) {
    switch(unit){
      case 'C':
        return "${kelvinToCelsius(temp).toStringAsFixed(2)} °C";
      case 'F':
        return "${kelvinToCelsius(temp).toStringAsFixed(2)} °F";
        default:
          return "${temp.toStringAsFixed(2)} °k";
    }
  }

  String? ConvertWindSpeed(double speed, String unit) {
    switch(unit){
      case 'Kilo':
        return "${meterPerSecondToKmPerHour(speed).toStringAsFixed(2)} KM/H";
      case 'Miles':
        return "${meterPerHourToMilesPerHour(speed).toStringAsFixed(2)} M/H";
      default:
        return "${speed.toStringAsFixed(2)} M/S";
    }
  }

  String? convertVisibility(int visibility, String unit) {
    switch(unit){
      case 'Kilo':
        return "${meterToKilometer(visibility).toStringAsFixed(2)} KM";
      case 'Miles':
        return "${meterToMile(visibility).toStringAsFixed(2)} MI";
      default:
        return "${visibility.toStringAsFixed(2)} M";
    }
  }



  String? get SunriseTime {
    return formatTime(_weather!.sunrise);
  }

  WeatherViewModel(this._useCase, this._locationViewModel);

  void updateLocationViewModel(LocationViewModel newLocVM) {
    _locationViewModel = newLocVM;
  }

  Future<void> loadWeather() async {
    _loading = true;
    notifyListeners();

    await _locationViewModel.fetchCurrentLocation();

    if (_locationViewModel.position != null) {
      try {
        final pos = _locationViewModel.position!;
        _weather = await _useCase.getWeather(pos.latitude, pos.longitude);
        _error = null;
      } catch (e) {
        _error = e.toString();
        _weather = null;
      }
    } else {
      _error = _locationViewModel.error;
    }

    _loading = false;
    notifyListeners();
  }



  String formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time); // e.g., "06:45 AM"
  }

  double kelvinToFahrenheit(double kelvin) {
    return (kelvin - 273.15) * 9 / 5 + 32;
  }

  double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  double meterPerSecondToKmPerHour(double meterPerSecond) {
    return meterPerSecond * 3.6;
  }

  double meterPerHourToMilesPerHour(double meterPerHour) {
    return meterPerHour * 0.000621371;
  }

  double meterToMile(int meters) {
    return meters * 0.000621371;
  }

  double meterToKilometer(int meters) {
    return meters / 1000;
  }

}
