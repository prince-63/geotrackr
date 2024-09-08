import 'dart:convert';
import 'package:geotrackr/data/models/office_model.dart';
import 'package:geotrackr/domain/entities/office.dart';
import 'package:http/http.dart' as http;
import 'package:geotrackr/domain/repositories/office_repository.dart';

class OfficeRepositoryImpl implements OfficeRepository {
  final String baseUrl;

  OfficeRepositoryImpl(this.baseUrl);

  @override
  Future<Office> getOffice(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/offices/$id'));

    if (response.statusCode == 200) {
      return OfficeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load office');
    }
  }
}
