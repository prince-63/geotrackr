import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData leadingIcon;
  final String text;
  final IconData trailingIcon;
  final VoidCallback onPressed;

  CustomIconButton({
    required this.leadingIcon,
    required this.text,
    required this.trailingIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(leadingIcon, color: Colors.black.withOpacity(0.8), size: 22.0),
                SizedBox(width: 8.0),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Icon(trailingIcon, color: Colors.black.withOpacity(0.8), size: 20.0),
          ],
        ),
      ),
    );
  }
}
