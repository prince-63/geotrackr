import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:idcard/config/api_config.dart';
import 'package:idcard/src/utils/share_preferences.dart';
import 'package:idcard/src/utils/uri_parser.dart';
import 'package:path/path.dart';

class ProfileService {
  static Future<void> uploadProfileImage(BuildContext context,
      Stream<List<int>> stream, int length, String filePath) async {
    var uri = UriParser.parse(ApiConfig.uploadProfileImage);

    String? token = await SharePreferences.getString('token');

    var request = http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = 'Bearer $token';

    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(filePath), contentType: MediaType('image', 'jpeg'));

    request.files.add(multipartFile);
    var response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile image uploaded successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushNamed(context, "/upload/profile-details");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to upload profile image!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  static Future<void> uploadProfileDetails(
      BuildContext context, Map<String, String> data) async {
    var uri = UriParser.parse(ApiConfig.uploadProfileDetails);

    String? token = await SharePreferences.getString('token');

    var response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile details uploaded successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushNamed(context, "/home");
    } else {
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to upload profile details!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  static Future<Map<String, dynamic>?> getUserProfile(
      BuildContext context) async {
    final url = ApiConfig.getUserProfile;
    String? token = await SharePreferences.getString('token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load user data!'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
