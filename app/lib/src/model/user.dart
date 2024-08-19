class User {
  final String id;
  final String username;
  final String email;
  final String? profilePictureUrl;
  final String password;
  final String? name;
  final String? contactNumber;
  final String? dateOfBirth;
  final String? bloodGroup;
  final String? address;
  final String? organizationName;
  final String? organizationAddress;
  final String? organizationContactEmail;
  final String? organizationContactNumber;
  final String? organizationLocation;
  final bool? emailVerified;
  final String? emailVerificationCode;
  final String? passwordResetVerificationCode;
  final List<Attendance> attendances;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.profilePictureUrl,
    required this.password,
    this.name,
    this.contactNumber,
    this.dateOfBirth,
    this.bloodGroup,
    this.address,
    this.organizationName,
    this.organizationAddress,
    this.organizationContactEmail,
    this.organizationContactNumber,
    this.organizationLocation,
    this.emailVerified = false,
    this.emailVerificationCode,
    this.passwordResetVerificationCode,
    required this.attendances,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      password: json['password'] as String,
      name: json['name'] as String?,
      contactNumber: json['contactNumber'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      bloodGroup: json['bloodGroup'] as String?,
      address: json['address'] as String?,
      organizationName: json['organizationName'] as String?,
      organizationAddress: json['organizationAddress'] as String?,
      organizationContactEmail: json['organizationContactEmail'] as String?,
      organizationContactNumber: json['organizationContactNumber'] as String?,
      organizationLocation: json['organizationLocation'] as String?,
      emailVerified: json['emailVerified'] as bool?,
      emailVerificationCode: json['emailVerificationCode'] as String?,
      passwordResetVerificationCode:
          json['passwordResetVerificationCode'] as String?,
      attendances: (json['attendances'] as List<dynamic>)
          .map((e) => Attendance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'password': password,
      'name': name,
      'contactNumber': contactNumber,
      'dateOfBirth': dateOfBirth,
      'bloodGroup': bloodGroup,
      'address': address,
      'organizationName': organizationName,
      'organizationAddress': organizationAddress,
      'organizationContactEmail': organizationContactEmail,
      'organizationContactNumber': organizationContactNumber,
      'organizationLocation': organizationLocation,
      'emailVerified': emailVerified,
      'emailVerificationCode': emailVerificationCode,
      'passwordResetVerificationCode': passwordResetVerificationCode,
      'attendances': attendances.map((e) => e.toJson()).toList(),
    };
  }
}

class Attendance {
  final String id;
  final String userId;
  final DateTime date;
  final AttendanceStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Attendance({
    required this.id,
    required this.userId,
    required this.date,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['_id'] as String,
      userId: json['userId'] as String,
      date: DateTime.parse(json['date'] as String),
      status: AttendanceStatus.values.firstWhere(
          (e) => e.toString() == 'AttendanceStatus.${json['status']}'),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

enum AttendanceStatus {
  PRESENT,
  ABSENT,
  LATE,
  ON_LEAVE,
}
