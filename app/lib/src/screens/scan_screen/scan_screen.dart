import 'package:app/api/attendance_api.dart';
import 'package:app/src/utils/custom_media_query.dart';
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
            _buildHeader(),
            const SizedBox(height: 10),
            _buildQRView(),
            const SizedBox(height: 20),
            _buildQRTextDisplay(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      alignment: Alignment.center,
      width: CustomMediaQuery.screenWidth(context),
      height: CustomMediaQuery.screenHeight(context) * 0.1,
      child: Text(
        'Scan Your Id Card',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget _buildQRView() {
    return Container(
      alignment: Alignment.center,
      width: CustomMediaQuery.screenWidth(context),
      height: CustomMediaQuery.screenHeight(context) * 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 7,
          cutOutSize: CustomMediaQuery.screenWidth(context) * 0.7,
        ),
      ),
    );
  }

  Widget _buildQRTextDisplay() {
    return Container(
      alignment: Alignment.center,
      width: CustomMediaQuery.screenWidth(context) * 0.8,
      height: CustomMediaQuery.screenHeight(context) * 0.1,
      child: Text(
        qrText ?? 'QR Incoded Text',
        style: Theme.of(context).textTheme.bodyLarge,
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
