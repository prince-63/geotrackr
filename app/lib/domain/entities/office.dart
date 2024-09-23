/// This class represents an office.
/// It includes details such as name, email, contact number, and location.
class Office {
  final String? officeId; // The unique identifier for the office.
  final String? officeName; // The name of the office.
  final String? officeEmail; // The email address of the office.
  final String? officeContactNumber; // The contact number of the office.
  final String? officeSubTitle; // The subtitle or description of the office.
  final String? officeCity; // The city where the office is located.
  final String? officeState; // The state where the office is located.
  final String? officeCountry; // The country where the office is located.
  final String? officePincodes; // The pincodes associated with the office.
  final String? officeLongitude; // The longitude of the office location.
  final String? officeLatitude; // The latitude of the office location.

  /// Constructor for [Office].
  /// It initializes the office with the given parameters.
  Office({
    this.officeId,
    this.officeName,
    this.officeEmail,
    this.officeContactNumber,
    this.officeSubTitle,
    this.officeCity,
    this.officeState,
    this.officeCountry,
    this.officePincodes,
    this.officeLongitude,
    this.officeLatitude,
  });

  /// Factory constructor to create an [Office] instance from a JSON map.
  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      officeId: json['officeId'], // The unique identifier from the JSON map.
      officeName: json['officeName'], // The name from the JSON map.
      officeEmail: json['officeEmail'], // The email address from the JSON map.
      officeContactNumber:
          json['officeContactNumber'], // The contact number from the JSON map.
      officeSubTitle: json['officeSubTitle'], // The subtitle from the JSON map.
      officeCity: json['officeCity'], // The city from the JSON map.
      officeState: json['officeState'], // The state from the JSON map.
      officeCountry: json['officeCountry'], // The country from the JSON map.
      officePincodes: json['officePincodes'], // The pincodes from the JSON map.
      officeLongitude:
          json['officeLongitude'], // The longitude from the JSON map.
      officeLatitude: json['officeLatitude'], // The latitude from the JSON map.
    );
  }

  /// Converts the [Office] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'officeId': officeId, // The unique identifier of the office.
      'officeName': officeName, // The name of the office.
      'officeEmail': officeEmail, // The email address of the office.
      'officeContactNumber':
          officeContactNumber, // The contact number of the office.
      'officeSubTitle': officeSubTitle, // The subtitle of the office.
      'officeCity': officeCity, // The city where the office is located.
      'officeState': officeState, // The state where the office is located.
      'officeCountry':
          officeCountry, // The country where the office is located.
      'officePincodes':
          officePincodes, // The pincodes associated with the office.
      'officeLongitude':
          officeLongitude, // The longitude of the office location.
      'officeLatitude': officeLatitude, // The latitude of the office location.
    };
  }
}
