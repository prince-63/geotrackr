import 'package:idcard/src/screens/scan/scan_screen.dart';
import 'package:flutter/material.dart';
import 'widgets/home_content.dart';
import 'widgets/bottom_navigation.dart';
import 'package:idcard/src/screens/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  static List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    ScanScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    FocusScope.of(context).unfocus(); // Unfocus any focused widget
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Set the background color of the whole screen
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: _widgetOptions,
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
