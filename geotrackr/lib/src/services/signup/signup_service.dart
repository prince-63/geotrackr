import 'dart:convert';

import 'package:idcard/src/config/api_config.dart';
import 'package:idcard/src/utils/share_preferences.dart';
import 'package:idcard/src/utils/uri_parser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupService {
  static void signup(String username, String email, String password,
      BuildContext context) async {
    final url = UriParser.parse(ApiConfig.authSignup);

    if (username.isEmpty) {
      throw Exception('Please enter a valid username');
    }

    if (email.isEmpty) {
      throw Exception('Please enter a valid email');
    }

    if (password.isEmpty) {
      throw Exception('Please enter a valid password');
    }

    await _postRequest(url,
        {'username': username, 'email': email, 'password': password}, context);
  }

  static Future<void> _postRequest(
      Uri url, Map<String, String> body, BuildContext context) async {
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        final token = responseBody['data']['token'];
        final email = responseBody['data']['email'];

        if (token != null && email != null) {
          SharePreferences.saveString('token', token);
          SharePreferences.saveString('email', email);
          Navigator.pushNamed(context, '/user-verification');
        } else {
          throw Exception('Failed to signup: ${response.body}');
        }
      } else {
        throw Exception('Failed to signup: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to signup: ${e.toString()}');
    }
  }
}
