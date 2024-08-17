import 'dart:convert';
import 'package:idcard/config/api_config.dart';
import 'package:idcard/src/utils/share_preferences.dart';
import 'package:idcard/src/utils/uri_parser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserVerificationService {
  static void verifyUser(String code, BuildContext context) async {
    if (code.length != 6) {
      throw Exception('Please enter a 6 digit valid code');
    }

    final url = UriParser.parse(ApiConfig.verifyEmail);
    String? token = await SharePreferences.getString("token");

    if (token == null) {
      throw Exception('Token not found');
    }

    await _postRequest(url, {'code': code}, token, context);
  }

  static Future<void> _postRequest(Uri url, Map<String, String> body,
      String token, BuildContext context) async {
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        print(responseBody);
        final status = responseBody['status'];
        final message = responseBody['message'];

        if (status == 'success') {
          Navigator.pushNamed(context, '/home');
        } else {
          throw Exception('Failed to verify user: $message');
        }
      } else {
        throw Exception('Failed to verify user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to verify user: ${e.toString()}');
    }
  }
}
