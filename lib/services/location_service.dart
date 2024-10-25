import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static getLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("service disabled")));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("if you don't allow acces we can't fetch weather data!")));
        permission = await Geolocator.requestPermission();
      }
    }
  }
}
