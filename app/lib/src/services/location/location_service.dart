import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:idcard/src/config/api_config.dart';
import 'package:idcard/src/utils/share_preferences.dart';
import 'package:idcard/src/widgets/custom_messages.dart';
import 'package:http/http.dart' as http;

class LocationService {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error('Location permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<Map<String, String>> getOrganizationLocation(
      BuildContext context) async {
    String? token = await SharePreferences.getString('token');
    if (token == null) {
      CustomMessages.showBeautifulMessage(
          context, "You are not authorized to access this feature");
      Navigator.pushNamed(context, "/login");
      return {};
    }

    Uri url = Uri.parse(ApiConfig.getOrganizationLocation);

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return {
        'latitude': responseBody['data']['latitude'],
        'longitude': responseBody['data']['longitude']
      };
    } else {
      CustomMessages.showBeautifulMessage(
          context, "Failed to get organization location");
      return {};
    }
  }

  static Map<String, double> convertStringToDouble(Map<String, String> data) {
    return {
      'latitude': double.parse(data['latitude']!),
      'longitude': double.parse(data['longitude']!)
    };
  }

  static double roundToSixDecimals(double value) {
    return double.parse(value.toStringAsFixed(6));
  }

  static double calculateLocationDistance(
      Position _currentPosition, Map<String, double> _organizationPosition) {
    print('before rounding: ${_currentPosition.latitude}');
    print('before rounding: ${_currentPosition.longitude}');
    double currentLatitude = roundToSixDecimals(_currentPosition.latitude);
    double currentLongitude = roundToSixDecimals(_currentPosition.longitude);
    print('Current Position Latitude: ${currentLatitude}');
    print('Current Position Longitude: ${currentLongitude}');
    print(
        'Organization Position Latitude: ${_organizationPosition['latitude']}');
    print(
        'Organization Position Longitude: ${_organizationPosition['longitude']}');

    double distanceInMeters = Geolocator.distanceBetween(
      currentLatitude,
      currentLongitude,
      _organizationPosition['longitude']!,
      _organizationPosition['latitude']!,
    );

    return distanceInMeters;
  }
}
