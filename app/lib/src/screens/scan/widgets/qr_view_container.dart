import 'package:idcard/src/utils/custom_media_query.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewContainer extends StatelessWidget {
  final GlobalKey qrKey;
  final Function(QRViewController) onQRViewCreated;

  const QRViewContainer({
    required this.qrKey,
    required this.onQRViewCreated,
  });

  @override
  Widget build(BuildContext context) {
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
        onQRViewCreated: onQRViewCreated,
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
}