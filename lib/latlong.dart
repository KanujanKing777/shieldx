import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class LocationService {
  static final LocationService _instance = LocationService._internal();

  factory LocationService() {
    return _instance;
  }

  LocationService._internal();

  Future<List<double>> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return [0.0, 0.0];
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return [0.0, 0.0];
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return [0.0, 0.0];
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return [position.latitude, position.longitude];
    } catch (e) {
      print("Error getting location: $e");
      return [0.0, 0.0];
    }
  }
}
