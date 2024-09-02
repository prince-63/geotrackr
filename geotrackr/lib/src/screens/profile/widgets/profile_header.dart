import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String profileImageUrl;
  final String username;
  final String name;

  const ProfileHeader({
    Key? key,
    required this.profileImageUrl,
    required this.username,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(radius: 80, backgroundImage: NetworkImage(profileImageUrl)),
              const SizedBox(height: 10),
              Text(
                '@'+username,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
