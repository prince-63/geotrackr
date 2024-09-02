import 'package:flutter/material.dart';
import 'package:idcard/src/utils/custom_media_query.dart';

class ProfileImageUploadHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  ProfileImageUploadHeader({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
      height: CustomMediaQuery.screenHeight(context) * 0.15,
      width: CustomMediaQuery.screenWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black.withOpacity(0.9),
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5.0),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(0.85),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
