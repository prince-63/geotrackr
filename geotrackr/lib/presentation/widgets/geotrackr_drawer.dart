import 'package:flutter/material.dart';
import 'package:geotrackr/utils/custom_color.dart';

class GeoTrackrDrawer extends StatelessWidget {
  const GeoTrackrDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDarkMode ? CustomColor.darkTextColor : CustomColor.lightTextColor;
    final backgroundColor = isDarkMode
        ? CustomColor.darkBackgroundColor
        : CustomColor.lightBackgroundColor;

    return Drawer(
      backgroundColor: backgroundColor,
      width: 270,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 65,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: backgroundColor,
                border: const Border(
                  bottom: BorderSide.none,
                ),
              ),
              child: Row(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/icons/app_icon.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const Center(
                    child: Text(
                      'GeoTrackr',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_2_outlined),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, "/profile");
            },
          ),
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: Text('Office', style: TextStyle(color: textColor)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: Text(
              'Geolocation Check-In/Out',
              style: TextStyle(
                color: textColor,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: Text(
              'Manual Check-In/Out',
              style: TextStyle(
                color: textColor,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: Text(
              'Working Hours',
              style: TextStyle(
                color: textColor,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text(
              'Calendar',
              style: TextStyle(
                color: textColor,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.video_library),
            title: Text(
              'Learn',
              style: TextStyle(
                color: textColor,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                color: textColor,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: Text(
              'Help & Support',
              style: TextStyle(
                color: textColor,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/help-and-support");
            },
          ),
          const Divider(
            thickness: .5,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(
              'Logout',
              style: TextStyle(
                color: textColor,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
