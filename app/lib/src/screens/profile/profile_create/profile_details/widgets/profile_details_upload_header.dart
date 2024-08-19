import 'package:flutter/material.dart';
import 'package:idcard/src/utils/custom_media_query.dart';

class ProfileDetailsUploadHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      height: CustomMediaQuery.screenHeight(context) * 0.1,
      width: CustomMediaQuery.screenWidth(context),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Upload your profile details',
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
