import 'package:flutter/material.dart';
import 'package:idcard/src/widgets/back_button.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          BuildBackButton(),
                          Text(
                            'Help & Support',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Online Attendance Management App',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black.withOpacity(0.9),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            const Text(
                              'This app was developed to address the common challenges of attendance management systems in colleges and large organizations. Traditionally, users need to physically access an attendance machine to register their presence, which can be inconvenient. Our app eliminates this hassle by allowing users to mark their attendance directly from their phones through QR code scanning, wherever they are. and, it offers features for managing and reviewing daily attendance records, along with many other functionalities.',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
