import 'package:flutter/material.dart';

class SetNewPasswordImage extends StatelessWidget {
  const SetNewPasswordImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/set_new_password.png',
            width: 225,
            height: 225,
          )
        ],
      ),
    );
  }
}
