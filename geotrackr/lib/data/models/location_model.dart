import 'package:geotrackr/domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel({
    required super.latitude,
    required super.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
