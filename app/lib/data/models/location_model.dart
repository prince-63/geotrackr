import 'package:geotrackr/domain/entities/location.dart';

/// This class represents the model for location data.
/// It extends the [Location] entity and inherits its properties.
class LocationModel extends Location {
  /// Constructor for [LocationModel].
  /// It initializes the location model with the given latitude and longitude.
  LocationModel({
    required super.latitude, // The latitude of the location.
    required super.longitude, // The longitude of the location.
  });

  /// Factory constructor to create a [LocationModel] from a JSON map.
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'], // The latitude from the JSON map.
      longitude: json['longitude'], // The longitude from the JSON map.
    );
  }

  /// Converts the [LocationModel] instance to a JSON map.
  @override
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude, // The latitude of the location.
      'longitude': longitude, // The longitude of the location.
    };
  }
}
