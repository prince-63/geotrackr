import 'dart:convert';
import 'package:app/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final url = Uri.parse(ApiConfig.authLogin);

    try {
      final response =
          await _postRequest(url, {'email': email, 'password': password});
      return _handleLoginResponse(response);
    } catch (e) {
      _logError('Login Failed', e);
      throw Exception('Login Failed: $e');
    }
  }

  static Future<Map<String, dynamic>> signup(
      String username, String email, String password) async {
    final url = Uri.parse(ApiConfig.authSignup);

    try {
      final response = await _postRequest(
          url, {'username': username, 'email': email, 'password': password});
      return _handleSignupResponse(response);
    } catch (e) {
      _logError('Signup Failed', e);
      throw Exception('Signup Failed: $e');
    }
  }

  static Future<http.Response> _postRequest(
      Uri url, Map<String, String> body) async {
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }

  static Future<Map<String, dynamic>> _handleLoginResponse(
      http.Response response) async {
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];
      final email = responseBody['email'];
      await _storeToken(token, email);
      return responseBody;
    } else {
      throw Exception(
          'Failed to login: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<Map<String, dynamic>> _handleSignupResponse(
      http.Response response) async {
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];
      final email = responseBody['email'];
      await _storeToken(token, email);
      return responseBody;
    } else {
      throw Exception(
          'Failed to signup: ${response.statusCode} ${response.reasonPhrase} ${response.body}');
    }
  }

  static Future<void> _storeToken(String token, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
    await prefs.setString('user_email', email);
  }

  static void _logError(String message, Object error) {
    print('$message: $error');
  }
}
