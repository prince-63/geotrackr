import '../../domain/entities/office.dart';

class OfficeModel extends Office {
  OfficeModel({
    required super.officeId,
    required super.officeName,
    required super.officeEmail,
    super.officeContactNumber,
    super.officeSubTitle,
    super.officeCity,
    super.officeState,
    super.officeCountry,
    super.officePincodes,
    super.officeLongitude,
    super.officeLatitude,
    super.createdAt,
    super.updatedAt,
  });

  factory OfficeModel.fromJson(Map<String, dynamic> json) {
    return OfficeModel(
      officeId: json['_id'],
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
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': officeId,
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
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
