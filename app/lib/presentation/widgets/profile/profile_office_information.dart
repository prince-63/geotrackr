import 'package:flutter/material.dart';
import 'package:geotrackr/domain/entities/office.dart';
import 'package:geotrackr/presentation/widgets/data_display.dart';

class ProfileOfficeInformation extends StatelessWidget {
  final Office office;

  const ProfileOfficeInformation({
    super.key,
    required this.office,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? const Color.fromARGB(255, 51, 56, 61)
        : const Color.fromARGB(255, 250, 253, 255);
    final textColor = !isDarkMode ? Colors.black : Colors.white;

    return Column(
      children: [
        // title
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Office Information',
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
          data: office.officeName ?? '',
          textColor: textColor,
          backgroundColor: backgroundColor,
        ),
        DataDisplay(
          label: 'Email',
          data: office.officeEmail ?? '',
          textColor: textColor,
          backgroundColor: backgroundColor,
        ),
        DataDisplay(
          label: 'Phone',
          data: office.officeContactNumber ?? '',
          textColor: textColor,
          backgroundColor: backgroundColor,
        ),
        DataDisplay(
          label: 'City',
          data: office.officeCity ?? '',
          textColor: textColor,
          backgroundColor: backgroundColor,
        ),
        DataDisplay(
          label: 'State',
          data: office.officeState ?? '',
          textColor: textColor,
          backgroundColor: backgroundColor,
        ),
        DataDisplay(
          label: 'Country',
          data: office.officeCountry ?? '',
          textColor: textColor,
          backgroundColor: backgroundColor,
        ),
        DataDisplay(
          label: 'Pincodes',
          data: office.officePincodes ?? '',
          textColor: textColor,
          backgroundColor: backgroundColor,
        ),
      ],
    );
  }
}
