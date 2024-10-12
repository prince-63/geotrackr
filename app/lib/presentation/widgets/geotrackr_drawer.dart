import 'package:flutter/material.dart';
import 'package:geotrackr/utils/custom_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A custom drawer widget for the GeoTrackr application.
/// It includes navigation options for profile, working hours, settings, help & support, and logout.
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

    /// Clears all application data and navigates to the login screen.
    Future<void> clearAllAppData() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    }

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
            leading: const Icon(Icons.access_time),
            title: Text(
              'Working Hours',
              style: TextStyle(
                color: textColor,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/working-hours");
            },
          ),
          const Divider(),
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
              clearAllAppData();
            },
          ),
        ],
      ),
    );
  }
}
