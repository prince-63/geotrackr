import 'package:flutter/material.dart';
import 'package:idcard/src/screens/profile/profile_create/profile_image/widgets/profile_action_button.dart';
import 'package:idcard/src/screens/profile/profile_create/profile_image/widgets/profile_image_upload_header.dart';
import 'package:idcard/src/services/profile/profile_service.dart';
import 'package:idcard/src/widgets/back_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class ProfileImageUploadScreen extends StatefulWidget {
  @override
  _ProfileImageUploadScreenState createState() =>
      _ProfileImageUploadScreenState();
}

class _ProfileImageUploadScreenState extends State<ProfileImageUploadScreen> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _uploadImage() async {
      if (_image == null) return;

      var stream = http.ByteStream(DelegatingStream.typed(_image!.openRead()));
      var length = await _image!.length();

      ProfileService.uploadProfileImage(context, stream, length, _image!.path);
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              BuildBackButton(),
              const SizedBox(height: 10.0),
              ProfileImageUploadHeader(
                title: 'Upload Profile Image',
                subtitle: 'Maximum file size: 10MB And Ratio: 400x400',
              ),
              _image == null
                  ? const Text('No image selected.')
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Image.file(
                        _image!,
                        width: 380,
                        height: 380,
                      ),
                    ),
              _image == null
                  ? const SizedBox(height: 300.0)
                  : const SizedBox(height: 0.0),
              ProfileActionButton(
                pickImage: _pickImage,
                uploadImage: _uploadImage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
