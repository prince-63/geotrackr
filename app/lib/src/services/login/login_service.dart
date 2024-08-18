import 'dart:convert';

import 'package:idcard/config/api_config.dart';
import 'package:idcard/src/utils/share_preferences.dart';
import 'package:idcard/src/utils/uri_parser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static void login(String text, String password, BuildContext context) async {
    final url = UriParser.parse(ApiConfig.authLogin);
    late String username = '';
    late String email = '';

    if (text.contains('@')) {
      email = text;
    } else {
      username = text;
    }

    if (email.isEmpty && username.isEmpty) {
      throw Exception('Please enter a valid email or username');
    }

    if (password.isEmpty) {
      throw Exception('Please enter a valid password');
    }

    if (email.isNotEmpty && username.isEmpty) {
      await _postRequest(url, {'email': email, 'password': password}, context);
      Navigator.pushNamed(context, '/singup');
    } else {
      await _postRequest(
          url, {'username': username, 'password': password}, context);
      Navigator.pushNamed(context, '/singup');
    }
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
          Navigator.pushNamed(context, '/home');
        } else {
          throw Exception('Failed to login: ${response.body}');
        }
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      throw Exception("Failed to login: ${e.toString()}");
    }
  }
}
