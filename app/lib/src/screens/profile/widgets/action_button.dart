import 'package:flutter/material.dart';
import 'package:idcard/src/screens/profile/widgets/custom_icon_button.dart';
import 'package:idcard/src/utils/custom_color.dart';

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: CustomColor.profileBoxColor,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              CustomIconButton(
                text: "View & Download",
                leadingIcon: Icons.download,
                trailingIcon: Icons.arrow_forward_ios,
                onPressed: () {
                  Navigator.pushNamed(context, '/view-and-download');
                },
              ),
              CustomIconButton(
                text: "Update Information",
                leadingIcon: Icons.edit,
                trailingIcon: Icons.arrow_forward_ios,
                onPressed: () {
                  Navigator.pushNamed(context, '#');
                },
              ),
              CustomIconButton(
                text: "Account",
                leadingIcon: Icons.account_circle,
                trailingIcon: Icons.arrow_forward_ios,
                onPressed: () {
                  Navigator.pushNamed(context, '/account');
                },
              ),
              CustomIconButton(
                text: "Help & Support",
                leadingIcon: Icons.help,
                trailingIcon: Icons.arrow_forward_ios,
                onPressed: () {
                  Navigator.pushNamed(context, '/help-and-support');
                },
              ),
              CustomIconButton(
                text: "About",
                leadingIcon: Icons.info,
                trailingIcon: Icons.arrow_forward_ios,
                onPressed: () {
                  Navigator.pushNamed(context, '/about');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
