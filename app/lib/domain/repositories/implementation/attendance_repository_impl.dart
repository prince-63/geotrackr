import 'dart:convert';

import 'package:geotrackr/domain/repositories/attendance_repository.dart';
import 'package:http/http.dart' as http;
import 'package:geotrackr/config/api_config.dart';
import 'package:geotrackr/domain/entities/attendance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  AttendanceRepositoryImpl();

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
        return responseBody.message;
      } else {
        final responseBody = jsonDecode(response.body);
        return responseBody['message'];
      }
    } catch (e) {
      throw Exception('Failed to check in');
    }
  }

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
          'checkInLocationLongitude': longitude,
          'checkInLocationLatitude': latitude,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return responseBody.message;
      } else {
        final responseBody = jsonDecode(response.body);
        return responseBody['message'];
      }
    } catch (e) {
      throw Exception('Failed to check out');
    }
  }

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
        print("Attendances: $attendances");
        return attendances;
      } else {
        throw Exception('Failed to load attendances');
      }
    } catch (e) {
      throw Exception('Failed to load attendances');
    }
  }
}
