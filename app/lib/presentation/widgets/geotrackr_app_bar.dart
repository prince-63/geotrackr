import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/presentation/blocs/employee/load_employee_bloc.dart';
import 'package:geotrackr/utils/custom_color.dart';

/// A custom AppBar widget for the GeoTrackr application.
/// It includes a menu button and a profile avatar that displays the employee's profile image.
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
              return Container(
                margin: const EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/profile");
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        imageUrl.isEmpty ? null : NetworkImage(imageUrl),
                    child: imageUrl.isEmpty
                        ? const Icon(Icons.person, color: Colors.white)
                        : null,
                  ),
                ),
              );
            } else if (state is LoadEmployeeLoading) {
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
