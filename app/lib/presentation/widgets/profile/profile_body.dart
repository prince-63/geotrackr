import 'package:flutter/material.dart';
import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/entities/office.dart';
import 'package:geotrackr/presentation/widgets/custom_button.dart';
import 'package:geotrackr/presentation/widgets/profile/profile_employee_information.dart';
import 'package:geotrackr/presentation/widgets/profile/profile_office_information.dart';

class ProfileBody extends StatelessWidget {
  final Employee employee;
  final Office office;

  const ProfileBody({super.key, required this.employee, required this.office});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardBackgroundColor = isDarkMode
        ? const Color.fromARGB(255, 51, 56, 61)
        : const Color.fromARGB(255, 250, 253, 255);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey,
              backgroundImage: (employee.employeeProfileImageUrl == null ||
                      employee.employeeProfileImageUrl!.isEmpty)
                  ? null
                  : NetworkImage(employee.employeeProfileImageUrl!),
              child: (employee.employeeProfileImageUrl == null ||
                      employee.employeeProfileImageUrl!.isEmpty)
                  ? const Icon(Icons.person, color: Colors.white, size: 80)
                  : null,
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
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              child: CustomButton(
                text: 'Upload Profile Image',
                onPressed: () {
                  Navigator.pushNamed(context, '/upload-profile-image');
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              child: CustomButton(
                text: 'Update Employee Information',
                onPressed: () {
                  Navigator.pushNamed(context, '/employee-update-information');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
