import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:idcard/config/api_config.dart';
import 'package:idcard/src/utils/custom_color.dart';
import 'package:idcard/src/utils/share_preferences.dart';
import 'package:idcard/src/widgets/back_button.dart';
import 'package:idcard/src/widgets/custom_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class ViewAndDownloadScreen extends StatefulWidget {
  @override
  _ViewAndDownloadScreenState createState() => _ViewAndDownloadScreenState();
}

class _ViewAndDownloadScreenState extends State<ViewAndDownloadScreen> {
  String? localFilePath;

  @override
  void initState() {
    super.initState();
    fetchPdf();
  }

  Future<void> fetchPdf() async {
    String? token = await SharePreferences.getString('token');
    // headers
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response =
        await http.get(Uri.parse(ApiConfig.downloadIdCard), headers: headers);

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/id_card.pdf');
      await file.writeAsBytes(bytes, flush: true);
      setState(() {
        localFilePath = file.path;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Permission denied'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> downloadPdf() async {
    String? token = await SharePreferences.getString('token');
    // headers
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    if (await Permission.storage.request().isGranted) {
      final response =
          await http.get(Uri.parse(ApiConfig.downloadIdCard), headers: headers);

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getExternalStorageDirectory();
        final file = File('${dir!.path}/id_card.pdf');
        await file.writeAsBytes(bytes, flush: true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                """Downloaded successfully \nFile location: ${dir.path}/id_card.pdf"""),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Permission denied'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Permission denied'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: fetchPdf,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 10.0),
                BuildBackButton(),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text(
                        "Download Your Id Card",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40.0),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      localFilePath != null
                          ? Container(
                              height: 403,
                              width: 255,
                              child: PDFView(
                                filePath: localFilePath!,
                              ))
                          : const Center(child: CircularProgressIndicator()),
                      const SizedBox(height: 40.0),
                      CustomButton(
                        onPressed: downloadPdf,
                        text: "Download",
                        color: CustomColor.primaryValue,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
