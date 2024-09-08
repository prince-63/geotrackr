import 'package:flutter/material.dart';
import 'package:geotrackr/presentation/pages/profile_page.dart';
import 'package:geotrackr/utils/custom_color.dart';

class GeoTrackrAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GeoTrackrAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDarkMode ? CustomColor.darkTextColor : CustomColor.lightTextColor;

    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.menu, color: textColor),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 15),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://res.cloudinary.com/dysmrirqf/image/upload/v1724207599/profile_pictures/66c551c5e66bbd8fcdfc78ac_profile_picture.png'),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
