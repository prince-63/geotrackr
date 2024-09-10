import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/repositories/employee_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/load_employee.dart';
import 'package:geotrackr/presentation/blocs/load_employee_bloc.dart';
import 'package:geotrackr/presentation/widgets/geotrackr_app_bar.dart';
import 'package:geotrackr/presentation/widgets/geotrackr_drawer.dart';
import 'package:geotrackr/utils/custom_color.dart'; // Import the custom app bar

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // ignore: unused_local_variable
    final textColor =
        isDarkMode ? CustomColor.darkTextColor : CustomColor.lightTextColor;
    final backgroundColor = isDarkMode
        ? CustomColor.darkBackgroundColor
        : CustomColor.lightBackgroundColor;

    return BlocProvider(
      create: (context) {
        final bloc = LoadEmployeeBloc(
          loadEmployee: LoadEmployee(EmployeeRepositoryImpl()),
        );
        bloc.load(); // Automatically call the load function
        return bloc;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: const GeoTrackrAppBar(),
        drawer: const SafeArea(
          top: true,
          child: GeoTrackrDrawer(),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(
                    title: Text('Item #$index'),
                  ),
                  childCount: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
