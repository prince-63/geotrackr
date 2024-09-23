import '../../domain/entities/office.dart';

/// This class represents the model for office data.
/// It extends the [Office] entity and inherits its properties.
class OfficeModel extends Office {
  /// Constructor for [OfficeModel].
  /// It initializes the office model with the given parameters.
  OfficeModel({
    super.officeId, // The unique identifier for the office.
    super.officeName, // The name of the office.
    super.officeEmail, // The email address of the office.
    super.officeContactNumber, // The contact number of the office.
    super.officeSubTitle, // The subtitle or description of the office.
    super.officeCity, // The city where the office is located.
    super.officeState, // The state where the office is located.
    super.officeCountry, // The country where the office is located.
    super.officePincodes, // The pincodes associated with the office.
    super.officeLongitude, // The longitude of the office location.
    super.officeLatitude, // The latitude of the office location.
  });

  /// Factory constructor to create an [OfficeModel] from a JSON map.
  factory OfficeModel.fromJson(Map<String, dynamic> json) {
    return OfficeModel(
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

  /// Converts the [OfficeModel] instance to a JSON map.
  @override
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
