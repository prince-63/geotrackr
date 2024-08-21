import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:idcard/src/config/api_config.dart';
import 'package:idcard/src/services/location/location_service.dart';
import 'package:idcard/src/utils/share_preferences.dart';
import 'dart:convert';

import 'package:idcard/src/widgets/custom_messages.dart';

class AttendanceService {
  static Future<void> checkIn(
      BuildContext context,
      String encodedText,
      Position currentPosition,
      Map<String, String> organizationLocation) async {
    Map<String, double> convertedLocation =
        LocationService.convertStringToDouble(organizationLocation);

    // Calculate the distance between the current location and the organization location
    double totalDistanceInMeters = LocationService.calculateLocationDistance(
        currentPosition, convertedLocation);

    print("Total Distance: $totalDistanceInMeters");

    // If the distance is greater than 200 meters, show a message to the user
    if (totalDistanceInMeters > 200) {
      CustomMessages.showBeautifulMessage(
          context, 'You are not in the range of 200 Meters.');
      return;
    }

    // If the distance is less than 200 meters, mark the attendance
    Uri url = Uri.parse(ApiConfig.checkInAttendance);

    String? token = await SharePreferences.getString('token');
    if (token == null) {
      CustomMessages.showBeautifulMessage(
          context, 'You are not authorized to access this feature');
      Navigator.pushNamed(context, '/login');
      return;
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'qrText': encodedText}),
      );
      if (response.statusCode == 200) {
        CustomMessages.showBeautifulMessage(
            context, 'Attendance marked successfully');
        Navigator.pushNamed(context, '/thank-screen-in');
      } else {
        final responseJson = jsonDecode(response.body);
        CustomMessages.showBeautifulMessage(context, responseJson['message']);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> checkOut(
      BuildContext context,
      String encodedText,
      Position currentPosition,
      Map<String, String> organizationLocation) async {
    Map<String, double> convertedLocation =
        LocationService.convertStringToDouble(organizationLocation);

    // Calculate the distance between the current location and the organization location
    double totalDistanceInMeters = LocationService.calculateLocationDistance(
        currentPosition, convertedLocation);

    print("Total Distance: $totalDistanceInMeters");

    // If the distance is greater than 200 meters, show a message to the user
    if (totalDistanceInMeters > 200) {
      CustomMessages.showBeautifulMessage(
          context, 'You are not in the range of 200 Meters.');
      return;
    }

    // If the distance is less than 200 meters, mark the attendance
    Uri url = Uri.parse(ApiConfig.checkOutAttendance);

    String? token = await SharePreferences.getString('token');
    if (token == null) {
      CustomMessages.showBeautifulMessage(
          context, 'You are not authorized to access this feature');
      Navigator.pushNamed(context, '/login');
      return;
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'qrText': encodedText}),
      );
      if (response.statusCode == 200) {
        CustomMessages.showBeautifulMessage(
            context, 'Attendance marked successfully');
        Navigator.pushNamed(context, '/thank-screen-out');
      } else {
        CustomMessages.showBeautifulMessage(
            context, 'Failed to mark attendance');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<Map<DateTime, List<dynamic>>> getAllAttendance(
      BuildContext context) async {
    String? token = await SharePreferences.getString('token');

    if (token == null) {
      CustomMessages.showBeautifulMessage(
          context, 'You are not authorized to access this feature');
      Navigator.pushNamed(context, '/login');
      return {};
    }

    Uri url = Uri.parse(ApiConfig.getUserAttendance);

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        Map<DateTime, List<dynamic>> attendanceData = {};

        for (var data in responseJson['data']) {
          DateTime date = DateTime.parse(data['date']).toUtc();
          String status =
              data['status'].toUpperCase(); // Ensure status is in uppercase
          if (attendanceData.containsKey(date)) {
            attendanceData[date]!.add(status);
          } else {
            attendanceData[date] = [status];
          }
        }

        return attendanceData;
      } else {
        CustomMessages.showBeautifulMessage(
            context, 'Failed to get attendance data');
        return {};
      }
    } catch (e) {
      print(e.toString());
      CustomMessages.showBeautifulMessage(
          context, 'An error occurred while fetching attendance data');
      return {};
    }
  }
}
