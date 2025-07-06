import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class LocationViewModel extends ChangeNotifier {
  Position? _position;
  String? _error;

  Position? get position => _position;
  String? get error => _error;

  Future<void> fetchCurrentLocation() async {
    try {
      bool enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) {
        _error = "Location services disabled.";
        notifyListeners();
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _error = "Location permission denied.";
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _error = "Location permission permanently denied.";
        notifyListeners();
        return;
      }

      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.best,
      );

      _position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}