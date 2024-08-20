import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:idcard/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AttendanceApi {
  static Future<String> setAttendance(
      BuildContext context, String encodedText) async {
    try {
      final token = await _getToken();

      if (token == null) {
        Navigator.pushNamed(context, "/login");
        return 'Token not found, redirecting to login';
      }

      final response = await _sendPostRequest(token, encodedText);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        return responseBody['status'];
      } else {
        throw Exception(
            'Failed to mark attendence: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Attendence Failed: $e');
      throw Exception('Attendence Failed: $e');
    }
  }

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<http.Response> _sendPostRequest(
      String token, String encodedText) async {
    final url = Uri.parse(ApiConfig.setAttendence);
    return await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'encodedText': encodedText}), // Convert to JSON
    );
  }
}
