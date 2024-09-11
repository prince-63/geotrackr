import 'package:flutter/material.dart';
import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/presentation/widgets/data_display.dart';

class ProfileEmployeeInformation extends StatelessWidget {
  final Employee employee;

  const ProfileEmployeeInformation({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? const Color.fromARGB(255, 51, 56, 61)
        : const Color.fromARGB(255, 195, 222, 241);
    final textColor = !isDarkMode ? Colors.black : Colors.white;

    return Column(
      children: [
        // title
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Employee Information',
              style: TextStyle(
                color: textColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                backgroundColor: backgroundColor,
              ),
            ),
          ),
        ),
        DataDisplay(
          label: 'Name',
          data: employee.employeeName ?? '',
          textColor: textColor,
          backgroundColor: backgroundColor,
        ),
        DataDisplay(
          label: 'Email',
          data: employee.employeeEmail ?? '',
          textColor: textColor,
          backgroundColor: backgroundColor,
        ),
        DataDisplay(
          label: 'Phone',
          data: employee.employeeContactNumber ?? '',
          textColor: textColor,
          backgroundColor: backgroundColor,
        ),
      ],
    );
  }
}
