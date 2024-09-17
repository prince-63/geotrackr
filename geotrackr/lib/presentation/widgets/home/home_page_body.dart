import 'package:flutter/material.dart';
import 'package:geotrackr/presentation/widgets/home/check_box.dart';
import 'package:geotrackr/utils/custom_color.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  bool isCheckedIn = false;
  bool isCheckedOut = false;

  void _checkIn() {
    setState(() {
      isCheckedIn = true;
      isCheckedOut = false;
    });
  }

  void _checkOut() {
    setState(() {
      isCheckedOut = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDarkMode ? CustomColor.darkTextColor : CustomColor.lightTextColor;
    final backgroundColor = isDarkMode
        ? CustomColor.darkBackgroundColor
        : CustomColor.lightBackgroundColor;

    final today = DateTime.now();
    final dateString = '${today.day}/${today.month}/${today.year}';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CheckBox(
              context: context,
              title: 'Check-In',
              isChecked: isCheckedIn,
              onPressed: _checkIn,
              date: dateString,
              status: isCheckedIn ? 'Checked In' : 'Not Checked In',
              backgroundColor: backgroundColor,
              textColor: textColor,
            ),
            const SizedBox(height: 16.0),
            CheckBox(
              context: context,
              title: 'Check-Out',
              isChecked: isCheckedOut,
              onPressed: _checkOut,
              date: dateString,
              status: isCheckedOut ? 'Checked Out' : 'Not Checked Out',
              backgroundColor: backgroundColor,
              textColor: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
