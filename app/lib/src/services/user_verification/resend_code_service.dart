import 'package:idcard/config/api_config.dart';
import 'package:idcard/src/utils/share_preferences.dart';
import 'package:idcard/src/utils/uri_parser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResendCodeService {
  static Future<void> resendCode(BuildContext context) async {
    Uri uri = UriParser.parse(ApiConfig.resendVerificationEmail);
    String? token = await SharePreferences.getString("token");

    if (token == null) {
      throw Exception('Token not found');
    }

    await _postRequest(uri, token, context);
  }

  static Future<void> _postRequest(
      Uri uri, String token, BuildContext context) async {
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Resend Code Success');
      } else {
        throw Exception('Resend Code Failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Resend Code Failed: ${e.toString()}');
    }
  }
}
