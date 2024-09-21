import 'package:flutter/material.dart';
import 'package:geotrackr/utils/custom_color.dart';

/// A custom bottom navigation bar widget with customizable properties.
class BottomNavigation extends StatelessWidget {
  final int selectedIndex; // The index of the currently selected item.
  final Function(int)
      onItemTapped; // The callback to execute when an item is tapped.

  /// Constructor for [BottomNavigation].
  /// It initializes the class with the given parameters.
  const BottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final selectedColor =
        isDarkMode ? CustomColor.darkTextColor : CustomColor.lightTextColor;
    const unselectedColor = Color.fromARGB(255, 131, 131, 131);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(
              Icons.home_filled, 'Home', 0, selectedColor, unselectedColor),
          _buildNavItem(Icons.access_time, 'Attendance', 1, selectedColor,
              unselectedColor),
          _buildNavItem(Icons.calendar_today, 'Calendar', 2, selectedColor,
              unselectedColor),
        ],
      ),
    );
  }

  /// Builds a navigation item with the given properties.
  Widget _buildNavItem(IconData icon, String label, int index,
      Color selectedColor, Color unselectedColor) {
    final isSelected = selectedIndex == index;
    final color = isSelected ? selectedColor : unselectedColor;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: color),
          Text(
            label,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}
