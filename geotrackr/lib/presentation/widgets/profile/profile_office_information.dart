import 'package:flutter/material.dart';
import 'package:geotrackr/domain/entities/office.dart';
import 'package:geotrackr/presentation/widgets/data_display.dart';
import 'package:geotrackr/utils/custom_color.dart';

class ProfileOfficeInformation extends StatelessWidget {
  final Office office;

  const ProfileOfficeInformation({
    super.key,
    required this.office,
  });

  @override
  Widget build(BuildContext context) {
    const textColor = CustomColor.lightTextColor;
    const backgroundColor = CustomColor.appBarColor;

    return Column(
      children: [
        // title
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 10.0),
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
