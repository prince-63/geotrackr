import 'package:idcard/api/attendance_api.dart';
import 'package:idcard/src/screens/scan/widgets/qr_view_container.dart';
import 'package:idcard/src/screens/scan/widgets/scan_header.dart';
import 'package:flutter/material.dart';
import 'package:idcard/src/services/location/location_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:geolocator/geolocator.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qrText;
  bool _isAttendanceMarked = false;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }
  
Future<void> _initializeLocation() async {
    final position = await LocationService.getCurrentLocation();
    setState(() {
      _currentPosition = position;
    });
  }

  Future<void> _markAttendance() async {
    if (qrText != null && !_isAttendanceMarked) {
      try {
        final response = await AttendanceApi.setAttendance(context, qrText!);
        print('Attendance marked: $response');
      } catch (e) {
        print('Error marking attendance: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const SizedBox(height: 20),
            if (_currentPosition != null)
              Text(
                'Location: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
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
      if (!_isAttendanceMarked) {
        setState(() {
          qrText = scanData.code;
          _markAttendance();
        });
      }
    });
  }
}
