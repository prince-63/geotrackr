import 'package:flutter/material.dart';

/// This class handles the responsive layout for different screen sizes.
/// It displays different widgets based on the screen width.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile; // The widget to display on mobile screens.
  final Widget tablet; // The widget to display on tablet screens.
  final Widget desktop; // The widget to display on desktop screens.

  /// Constructor for [ResponsiveLayout].
  /// It initializes the class with the given widgets for mobile, tablet, and desktop.
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobile; // Display the mobile widget if the screen width is less than 600.
        } else if (constraints.maxWidth < 1200) {
          return tablet; // Display the tablet widget if the screen width is between 600 and 1200.
        } else {
          return desktop; // Display the desktop widget if the screen width is 1200 or more.
        }
      },
    );
  }
}
