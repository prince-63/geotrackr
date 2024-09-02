import 'package:flutter/material.dart';
import 'package:idcard/src/utils/custom_color.dart';
import 'package:idcard/src/utils/custom_media_query.dart';
import 'package:idcard/src/widgets/custom_button.dart';

class InOfficeLoginFooter extends StatelessWidget {
  const InOfficeLoginFooter({Key? key}) : super(key: key);

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
                  text: 'you are first time in the office then',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.75),
                    fontSize: 14.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'join now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.70),
                      ),
                    ),
                    TextSpan(
                      text: '.',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.85),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          CustomButton(
            onPressed: () {
              Navigator.pushNamed(context, '/join-as-in-office-employee');
            },
            text: 'Join Now',
            color: CustomColor.primaryValue,
          ),
        ],
      ),
    );
  }
}
