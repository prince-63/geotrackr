import 'package:idcard/src/screens/home/widgets/calender.dart';
import 'package:idcard/src/screens/scan/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:idcard/src/services/biometric/biometric_service.dart';
import 'widgets/bottom_navigation.dart';
import 'package:idcard/src/screens/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final BiometricService _biometricService = BiometricService();
  String? _authorized = 'Not Authorized';

  @override
  void initState() {
    super.initState();
    // _authenticate();
  }

  Future<void> _authenticate() async {
    bool authenticated = await _biometricService.authenticate();
    if (!mounted) return;

    setState(() {
      _authorized = authenticated ? 'Authorized' : 'Not Authorized';
    });

    if (_authorized != 'Authorized') {
      Navigator.pushNamed(context, "/login");
    }
  }

  void _onItemTapped(int index) {
    FocusScope.of(context).unfocus();
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: [
            Calender(),
            ScanScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
