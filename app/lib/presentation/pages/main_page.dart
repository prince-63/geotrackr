import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/repositories/implementation/employee_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/load_employee.dart';
import 'package:geotrackr/presentation/blocs/employee/load_employee_bloc.dart';
import 'package:geotrackr/presentation/pages/attendance_page.dart';
import 'package:geotrackr/presentation/pages/calender_page.dart';
import 'package:geotrackr/presentation/pages/home_page.dart';
import 'package:geotrackr/presentation/widgets/bottom_navigation.dart';
import 'package:geotrackr/presentation/widgets/geotrackr_app_bar.dart';
import 'package:geotrackr/presentation/widgets/geotrackr_drawer.dart';

/// The [MainPage] widget is a stateful widget that represents the main page of the application.
/// It includes a bottom navigation bar to switch between different pages (Home, Attendance, Calendar).
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // The index of the currently selected item in the bottom navigation bar.
  int _selectedIndex = 0;

  // A list of widgets representing the different pages that can be displayed.
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    AttendancePage(),
    CalenderPage(),
  ];

  /// Updates the selected index when an item in the bottom navigation bar is tapped.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // The BlocProvider is used to provide the LoadEmployeeBloc to the widget tree.
      create: (context) {
        final bloc = LoadEmployeeBloc(
          loadEmployee: LoadEmployee(
            employeeRepository: EmployeeRepositoryImpl(),
          ),
        );
        // Load the employee data when the bloc is created.
        bloc.load();
        return bloc;
      },
      // The Scaffold widget provides the structure for the main page.
      child: Scaffold(
        // The GeoTrackrAppBar widget is used as the app bar for the page.
        appBar: const GeoTrackrAppBar(),
        // The GeoTrackrDrawer widget is used as the navigation drawer for the page.
        drawer: const SafeArea(
          top: true,
          child: GeoTrackrDrawer(),
        ),
        // The body of the Scaffold displays the currently selected page.
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        // The BottomNavigation widget is used as the bottom navigation bar for the page.
        bottomNavigationBar: BottomNavigation(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
