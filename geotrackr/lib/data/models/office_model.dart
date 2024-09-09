import '../../domain/entities/office.dart';

class OfficeModel extends Office {
  OfficeModel({
    super.officeId,
    super.officeName,
    super.officeEmail,
    super.officeContactNumber,
    super.officeSubTitle,
    super.officeCity,
    super.officeState,
    super.officeCountry,
    super.officePincodes,
    super.officeLongitude,
    super.officeLatitude,
  });

  factory OfficeModel.fromJson(Map<String, dynamic> json) {
    return OfficeModel(
      officeId: json['officeId'],
      officeName: json['officeName'],
      officeEmail: json['officeEmail'],
      officeContactNumber: json['officeContactNumber'],
      officeSubTitle: json['officeSubTitle'],
      officeCity: json['officeCity'],
      officeState: json['officeState'],
      officeCountry: json['officeCountry'],
      officePincodes: json['officePincodes'],
      officeLongitude: json['officeLongitude'],
      officeLatitude: json['officeLatitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'officeId': officeId,
      'officeName': officeName,
      'officeEmail': officeEmail,
      'officeContactNumber': officeContactNumber,
      'officeSubTitle': officeSubTitle,
      'officeCity': officeCity,
      'officeState': officeState,
      'officeCountry': officeCountry,
      'officePincodes': officePincodes,
      'officeLongitude': officeLongitude,
      'officeLatitude': officeLatitude,
    };
  }
}
