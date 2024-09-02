import 'package:flutter/material.dart';
import 'package:idcard/src/screens/profile/widgets/custom_display_text_field.dart';
import 'package:idcard/src/utils/custom_color.dart';

class ProfileInformation extends StatelessWidget {
  final Map<String, dynamic>? userData;

  const ProfileInformation({Key? key, this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: CustomColor.profileBoxColor,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.all(4.0),
              child: Text(
                "Information",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  CustomDisplayTextField(
                    label: "Email",
                    value: userData?['email'] ?? 'N/A',
                    icon: Icons.email,
                  ),
                  CustomDisplayTextField(
                    label: "Phone",
                    value: userData?['contactNumber'] ?? 'N/A',
                    icon: Icons.phone,
                  ),
                  CustomDisplayTextField(
                    label: "Date of Birth",
                    value: userData?['dateOfBirth'] ?? 'N/A',
                    icon: Icons.calendar_today,
                  ),
                  CustomDisplayTextField(
                    label: "Blood Group",
                    value: userData?['bloodGroup'] ?? 'N/A',
                    icon: Icons.local_hospital,
                  ),
                  CustomDisplayTextField(
                    label: "Address",
                    value: userData?['address'] ?? 'N/A',
                    icon: Icons.location_on,
                  ),
                  CustomDisplayTextField(
                    label: "Organization Name",
                    value: userData?['organizationName'] ?? 'N/A',
                    icon: Icons.business,
                  ),
                  CustomDisplayTextField(
                    label: "Organization Email",
                    value: userData?['organizationContactEmail'] ?? 'N/A',
                    icon: Icons.email,
                  ),
                  CustomDisplayTextField(
                    label: "Organisation Address",
                    value: userData?['organizationAddress'] ?? 'N/A',
                    icon: Icons.location_city,
                  ),
                  CustomDisplayTextField(
                    label: "Organisation Phone",
                    value: userData?['organizationContactNumber'] ?? 'N/A',
                    icon: Icons.phone,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}