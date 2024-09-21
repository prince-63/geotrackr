import 'package:flutter/material.dart';
import 'package:geotrackr/utils/custom_color.dart';

/// A custom AppBar widget with animation and customizable properties.
class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title; // The title of the AppBar.
  final Color? bgColor; // The background color of the AppBar.
  final Color? titleColor; // The color of the title text.
  final double elevation; // The elevation of the AppBar.
  final VoidCallback onBackButtonPressed; // Callback for the back button press.

  /// Constructor for [DefaultAppBar].
  /// It initializes the class with the given parameters.
  const DefaultAppBar({
    super.key,
    required this.title,
    this.bgColor,
    this.titleColor,
    this.elevation = 4.0,
    required this.onBackButtonPressed,
  });

  @override
  _DefaultAppBarState createState() => _DefaultAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DefaultAppBarState extends State<DefaultAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDarkMode ? CustomColor.darkTextColor : CustomColor.lightTextColor;
    final backgroundColor = isDarkMode
        ? CustomColor.darkBackgroundColor
        : CustomColor.lightBackgroundColor;

    return AnimatedBuilder(
      animation: _opacityAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: AppBar(
            backgroundColor: widget.bgColor ?? backgroundColor,
            title: Text(
              widget.title,
              style: TextStyle(
                color: widget.titleColor ?? textColor,
                fontSize: 18,
              ),
            ),
            leading: IconButton(
              icon:
                  Icon(Icons.arrow_back, color: widget.titleColor ?? textColor),
              onPressed: widget.onBackButtonPressed,
            ),
            elevation: widget.elevation,
          ),
        );
      },
    );
  }
}
