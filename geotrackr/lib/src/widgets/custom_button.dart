import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final double borderRadius;
  final double padding;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color = Colors.blue,
    this.borderRadius = 4.0,
    this.padding = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleOnPressed,
      child: _buildButtonContainer(),
    );
  }

  void _handleOnPressed() {
    try {
      onPressed();
    } catch (e) {
      _logError('Button press failed', e);
    }
  }

  Widget _buildButtonContainer() {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: _buildBoxDecoration(),
      child: _buildButtonText(),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  Widget _buildButtonText() {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  void _logError(String message, Object error) {
    print('$message: $error');
  }
}