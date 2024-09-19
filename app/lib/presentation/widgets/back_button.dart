import 'package:flutter/material.dart';

class BuildBackButton extends StatelessWidget {
  const BuildBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BackButton(color: Colors.black.withOpacity(0.7)),
      ],
    );
  }
}
