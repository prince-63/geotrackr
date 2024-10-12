import 'dart:convert';

import 'package:geotrackr/domain/repositories/attendance_repository.dart';
import 'package:http/http.dart' as http;
import 'package:geotrackr/config/api_config.dart';
import 'package:geotrackr/domain/entities/attendance.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of the [AttendanceRepository] interface.
/// This class handles attendance-related operations such as check-in, check-out, and loading attendances.
class AttendanceRepositoryImpl implements AttendanceRepository {
  AttendanceRepositoryImpl();

  /// Handles the check-in process.
  /// Takes the longitude and latitude as parameters.
  /// Returns a response message indicating the result of the check-in.
  @override
  Future<String> checkIn(String longitude, String latitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.checkIn),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'checkInLocationLongitude': longitude,
          'checkInLocationLatitude': latitude,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return responseBody['message'];
      } else {
        final responseBody = jsonDecode(response.body);
        return responseBody['message'];
      }
    } catch (e) {
      throw Exception('Failed to check in');
    }
  }

  /// Handles the check-out process.
  /// Takes the longitude and latitude as parameters.
  /// Returns a response message indicating the result of the check-out.
  @override
  Future<String> checkOut(String longitude, String latitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.checkOut),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'checkOutLocationLongitude': longitude,
          'checkOutLocationLatitude': latitude,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return responseBody['message'];
      } else {
        final responseBody = jsonDecode(response.body);
        return responseBody['message'];
      }
    } catch (e) {
      throw Exception('Failed to check out');
    }
  }

  /// Loads the attendance records.
  /// Returns a list of [Attendance] objects.
  @override
  Future<List<Attendance>> loadAttendances() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.getAttendances),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List<dynamic> data = responseBody['data']['attendances'];
        List<Attendance> attendances =
            data.map((e) => Attendance.fromJson(e)).toList();
        return attendances;
      } else {
        throw Exception('Failed to load attendances');
      }
    } catch (e) {
      throw Exception('Failed to load attendances');
    }
  }

  @override
  Future<Attendance> loadTodayAttendance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.getTodayAttendance),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final attendanceData = responseBody['data']['attendances'];

        return Attendance.fromJson(attendanceData);
      } else {
        throw Exception('No attendance record found for today');
      }
    } catch (e) {
      throw Exception('Failed to load today\'s attendance: $e');
    }
  }
}
