import 'package:flutter/material.dart';

class BuildBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BackButton(color: Colors.black.withOpacity(0.7)),
      ],
    );
  }
}
