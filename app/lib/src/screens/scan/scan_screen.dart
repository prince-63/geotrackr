import 'package:idcard/api/attendance_api.dart';
import 'package:idcard/src/screens/scan/widgets/qr_view_container.dart';
import 'package:idcard/src/screens/scan/widgets/scan_header.dart';
import 'package:flutter/material.dart';
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
  bool _isAttendanceMarked = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> _markAttendance() async {
    if (qrText != null && !_isAttendanceMarked) {
      try {
        final response = await AttendanceApi.setAttendance(context, qrText!);
        _handleAttendanceResponse(response);
      } catch (e) {
        _handleAttendanceError(e);
      }
    }
  }

  void _handleAttendanceResponse(String response) {
    if (response == 'success') {
      setState(() {
        _isAttendanceMarked = true;
      });
      _showSnackBar('Attendance Marked');
    } else {
      _showSnackBar('Attendance Failed: $response');
    }
  }

  void _handleAttendanceError(Object error) {
    _showSnackBar('Attendance Failed: $error');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
      setState(() {
        qrText = scanData.code;
        _markAttendance();
      });
    });
  }
}
