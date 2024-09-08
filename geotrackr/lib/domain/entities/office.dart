class Office {
  final String officeId;
  final String officeName;
  final String officeEmail;
  final String? officeContactNumber;
  final String? officeSubTitle;
  final String? officeCity;
  final String? officeState;
  final String? officeCountry;
  final String? officePincodes;
  final String? officeLongitude;
  final String? officeLatitude;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Office({
    required this.officeId,
    required this.officeName,
    required this.officeEmail,
    this.officeContactNumber,
    this.officeSubTitle,
    this.officeCity,
    this.officeState,
    this.officeCountry,
    this.officePincodes,
    this.officeLongitude,
    this.officeLatitude,
    this.createdAt,
    this.updatedAt,
  });
}
