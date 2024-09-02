import 'package:idcard/src/utils/custom_media_query.dart';
import 'package:flutter/material.dart';

class ScanHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: CustomMediaQuery.screenWidth(context),
      height: CustomMediaQuery.screenHeight(context) * 0.1,
      child: Text(
        'Scan Your Id Card',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}