import 'dart:convert';

import 'package:geotrackr/domain/repositories/attendance_repository.dart';
import 'package:http/http.dart' as http;
import 'package:geotrackr/config/api_config.dart';
import 'package:geotrackr/domain/entities/attendance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  AttendanceRepositoryImpl();

  @override
  Future<bool> checkIn(String longitude, String latitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.checkIn),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'checkInLocationLongitude': longitude,
          'checkInLocationLatitude': latitude,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to check in');
    }
  }

  @override
  Future<bool> checkOut(String longitude, String latitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.checkOut),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'checkOutLocationLongitude': longitude,
          'checkOutLocationLatitude': latitude,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
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
        return data.map((e) => Attendance.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load attendances');
      }
    } catch (e) {
      throw Exception('Failed to load attendances');
    }
  }
}
