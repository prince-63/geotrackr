// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:idcard/src/config/api_config.dart';
import 'package:idcard/src/utils/share_preferences.dart';
import 'package:idcard/src/widgets/custom_messages.dart';
import 'package:http/http.dart' as http;

class InOfficeService {
  static Future<void> joinAsInOfficeEmployee(
      BuildContext context, String email, String password) async {
    Uri url = Uri.parse(ApiConfig.joinAsInOfficeEmployee);

    if (password.length < 8) {
      CustomMessages.showBeautifulMessage(
          context, 'Password must be at least 8 characters');
    }

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'employeeEmail': email,
          'employeePassword': password,
        }));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['data']['token'];

      SharePreferences.saveString('token', token);

      CustomMessages.showBeautifulMessage(
          context, 'Successfully joined as in office employee');
      Navigator.pushNamed(context, "/home");
    } else {
      CustomMessages.showBeautifulMessage(
          context, 'Failed to join as in office employee');
    }
  }

  Future<void> checkIn() async {
    // Check in the user
  }

  Future<void> checkOut() async {
    // Check out the user
  }
}
