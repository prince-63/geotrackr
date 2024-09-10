class Office {
  final String? officeId;
  final String? officeName;
  final String? officeEmail;
  final String? officeContactNumber;
  final String? officeSubTitle;
  final String? officeCity;
  final String? officeState;
  final String? officeCountry;
  final String? officePincodes;
  final String? officeLongitude;
  final String? officeLatitude;

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

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
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
