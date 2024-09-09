import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/presentation/blocs/load_employee_bloc.dart';
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
        BlocBuilder<LoadEmployeeBloc, LoadEmployeeState>(
          builder: (context, state) {
            if (state is LoadEmployeeLoaded) {
              final imageUrl = state.employee.employeeProfileImageUrl ?? '';
              print('EmployeeLoaded state: $imageUrl');
              return Container(
                margin: const EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()),
                    );
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
              );
            } else if (state is LoadEmployeeLoading) {
              print('EmployeeLoading state');
              return Container(
                margin: const EdgeInsets.only(right: 15),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                ),
              );
            }
            print('Default state');
            return Container(
              margin: const EdgeInsets.only(right: 15),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: textColor),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
