/// This class represents a geographical location.
/// It includes the latitude and longitude coordinates.
class Location {
  final double latitude; // The latitude of the location.
  final double longitude; // The longitude of the location.

  /// Constructor for [Location].
  /// It initializes the location with the given latitude and longitude.
  Location({required this.latitude, required this.longitude});

  /// Factory constructor to create a [Location] instance from a JSON map.
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'], // The latitude from the JSON map.
      longitude: json['longitude'], // The longitude from the JSON map.
    );
  }

  /// Converts the [Location] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude, // The latitude of the location.
      'longitude': longitude, // The longitude of the location.
    };
  }
}