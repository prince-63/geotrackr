import 'dart:convert';
import 'package:geotrackr/config/api_config.dart';
import 'package:geotrackr/data/models/office_model.dart';
import 'package:geotrackr/domain/entities/office.dart';
import 'package:http/http.dart' as http;
import 'package:geotrackr/domain/repositories/office_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of the [OfficeRepository] interface.
/// This class handles office-related operations such as loading office details.
class OfficeRepositoryImpl implements OfficeRepository {
  OfficeRepositoryImpl();

  /// Loads the office details.
  /// Returns an [Office] object if the details are successfully loaded.
  @override
  Future<Office> loadOffice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // Check for cached office details
    final cachedData = prefs.getString('officeDetails');
    if (cachedData != null) {
      final responseData = jsonDecode(cachedData);
      return OfficeModel.fromJson(responseData);
    }

    final response = await http.get(
      Uri.parse(ApiConfig.officeDetails),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // Cache office details
      prefs.setString(
          'officeDetails', jsonEncode(responseData['data']['office']));
      return OfficeModel.fromJson(responseData['data']['office']);
    } else {
      throw Exception('Failed to load office');
    }
  }
}