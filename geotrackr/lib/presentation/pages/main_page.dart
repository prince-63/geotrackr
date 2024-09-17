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

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    AttendancePage(),
    CalenderPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = LoadEmployeeBloc(
            loadEmployee: LoadEmployee(EmployeeRepositoryImpl()));
        bloc.load();
        return bloc;
      },
      child: Scaffold(
        appBar: const GeoTrackrAppBar(),
        drawer: const SafeArea(
          top: true,
          child: GeoTrackrDrawer(),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigation(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
