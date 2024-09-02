import 'package:flutter/material.dart';
import 'package:idcard/src/utils/custom_color.dart';
import 'package:idcard/src/utils/custom_media_query.dart';
import 'package:idcard/src/widgets/custom_button.dart';

class JoinAsOutOfficeEmployeeFooter extends StatelessWidget {
  const JoinAsOutOfficeEmployeeFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: CustomMediaQuery.screenWidth(context) * 0.78,
            alignment: Alignment.center,
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      'you are not joining first time then click below button.',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.75),
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          CustomButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            text: 'Log In',
            color: CustomColor.primaryValue,
          ),
        ],
      ),
    );
  }
}
