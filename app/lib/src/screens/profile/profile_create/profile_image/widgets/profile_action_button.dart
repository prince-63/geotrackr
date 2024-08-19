import 'package:flutter/material.dart';
import 'package:idcard/src/utils/custom_color.dart';
import 'package:idcard/src/widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';

class ProfileActionButton extends StatelessWidget {
  final Function _pickImage;
  final Function _uploadImage;

  ProfileActionButton(
      {required Function pickImage, required Function uploadImage})
      : _pickImage = pickImage,
        _uploadImage = uploadImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          CustomButton(
            onPressed: () => _pickImage(ImageSource.camera),
            text: 'Take Picture',
            color: CustomColor.primaryValue,
          ),
          const SizedBox(height: 10.0),
          CustomButton(
            onPressed: () => _pickImage(ImageSource.gallery),
            text: 'Choose from Gallery',
            color: CustomColor.primaryValue,
          ),
          const SizedBox(height: 10.0),
          CustomButton(
            onPressed: () => _uploadImage(),
            text: 'Upload Image',
            color: CustomColor.primaryValue,
          ),
        ],
      ),
    );
  }
}
