import 'package:geolocator/geolocator.dart';
import 'package:idcard/src/screens/scan/widgets/qr_view_container.dart';
import 'package:idcard/src/screens/scan/widgets/scan_header.dart';
import 'package:flutter/material.dart';
import 'package:idcard/src/services/attendance/attendance_service.dart';
import 'package:idcard/src/services/location/location_service.dart';
import 'package:idcard/src/widgets/custom_messages.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qrText;
  late bool _isAttendanceMarked;
  bool _isCheckingIn = true;
  Position? _currentPosition;
  late Map<String, String> _organizationLocation;

  @override
  void initState() {
    super.initState();
    _isAttendanceMarked = false;
    _getCurrentLocation();
    _getOrganizationLocation();
  }

  Future<void> _markAttendance() async {
    if (qrText == null) {
      CustomMessages.showBeautifulMessage(
          context, 'Scan QR code more correctly');
      return;
    }

    // print("isCheckingIn: $_isCheckingIn");
    _isCheckingIn ? _checkIn() : _checkOut();
  }

  void _getCurrentLocation() async {
    Position? position = await LocationService.getCurrentLocation();
    try {
      setState(() {
        _currentPosition = position;
      });
      print("Current Position: $_currentPosition");
    } catch (e) {
      print(e.toString());
    }
  }

  void _getOrganizationLocation() async {
    Map<String, String> orgLoc =
        await LocationService.getOrganizationLocation(context);
    try {
      setState(() {
        _organizationLocation = orgLoc;
      });
      print("Organization Location: $_organizationLocation");
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _checkIn() async {
    try {
      await AttendanceService.checkIn(
          context, qrText!, _currentPosition!, _organizationLocation);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _checkOut() async {
    try {
      await AttendanceService.checkOut(
          context, qrText!, _currentPosition!, _organizationLocation);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScanHeader(),
            const SizedBox(height: 10),
            QRViewContainer(
              qrKey: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
            const SizedBox(height: 60),
            // CustomToggleButtons(
            //   isCheckingIn: _isCheckingIn,
            //   isAttendanceMarked: _isAttendanceMarked,
            // ),

            // Display the QR code text
            Text(
              qrText ?? '',
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (_isAttendanceMarked == false) {
        setState(() {
          qrText = scanData.code;
          _markAttendance();
          _isAttendanceMarked = true;
        });
      }
    });

    // Add error handling for autofocus
    controller.resumeCamera().catchError((e) {
      print('Error resuming camera: $e');
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
