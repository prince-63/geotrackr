import 'package:flutter/material.dart';
import 'package:idcard/src/utils/custom_color.dart';

// ignore: must_be_immutable
class CustomToggleButtons extends StatefulWidget {
  bool isCheckingIn;
  bool isAttendanceMarked;

  CustomToggleButtons({
    required this.isCheckingIn,
    required this.isAttendanceMarked,
  });

  @override
  _CustomToggleButtonsState createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [widget.isCheckingIn, !widget.isCheckingIn];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: [widget.isCheckingIn, !widget.isCheckingIn],
      onPressed: (int index) {
        setState(() {
          widget.isCheckingIn = index == 0;
          widget.isAttendanceMarked = false;
          isSelected = [index == 0, index == 1];
        });
      },
      color:
          Colors.black.withOpacity(0.8), // Default color for unselected buttons
      selectedColor: Colors.white, // Color for selected buttons
      fillColor:
          CustomColor.primaryValue, // Background color for selected buttons
      borderColor: Colors.grey, // Border color for unselected buttons
      selectedBorderColor:
          CustomColor.primaryValue, // Border color for selected buttons
      borderRadius: BorderRadius.circular(8.0), // Rounded corners
      borderWidth: 1.0, // Border width
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text('Check In'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text('Check Out'),
        ),
      ],
    );
  }
}
