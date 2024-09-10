import 'package:flutter/material.dart';
import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/entities/office.dart';
import 'package:geotrackr/presentation/widgets/profile/profile_employee_information.dart';
import 'package:geotrackr/presentation/widgets/profile/profile_office_information.dart';
import 'package:geotrackr/utils/custom_color.dart';

class ProfileBody extends StatelessWidget {
  final Employee employee;
  final Office office;

  const ProfileBody({super.key, required this.employee, required this.office});

  @override
  Widget build(BuildContext context) {
    const cardBackgroundColor = CustomColor.appBarColor;

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 80,
              backgroundImage:
                  NetworkImage(employee.employeeProfileImageUrl ?? ''),
            ),
            const SizedBox(height: 30),
            Card(
              color: cardBackgroundColor,
              elevation: 1,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ProfileEmployeeInformation(employee: employee),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              color: cardBackgroundColor,
              elevation: 1,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ProfileOfficeInformation(office: office),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
