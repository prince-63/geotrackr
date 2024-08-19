import 'package:flutter/material.dart';

class ProfileImageUploadImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/image-upload.png',
            width: 225,
            height: 225,
          )
        ],
      ),
    );
  }
}
