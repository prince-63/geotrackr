import 'package:flutter/material.dart';
import 'package:idcard/src/screens/profile/profile_create/profile_details/widgets/profile_details_form_field.dart';
import 'package:idcard/src/screens/profile/profile_create/profile_details/widgets/profile_details_upload_header.dart';
import 'package:idcard/src/services/profile/profile_service.dart';
import 'package:idcard/src/utils/custom_color.dart';
import 'package:idcard/src/widgets/back_button.dart';
import 'package:idcard/src/widgets/custom_button.dart';

class ProfileDetailsUploadScreen extends StatefulWidget {
  const ProfileDetailsUploadScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileDetailsUploadScreenState createState() =>
      _ProfileDetailsUploadScreenState();
}

class _ProfileDetailsUploadScreenState
    extends State<ProfileDetailsUploadScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _organizationNameController =
      TextEditingController();
  final TextEditingController _organizationAddressController =
      TextEditingController();
  final TextEditingController _organizationContactNumberController =
      TextEditingController();
  // final TextEditingController _organizationLatitudeController =
  //     TextEditingController();
  // final TextEditingController _organizationLongitudeController =
  //     TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Map<String, String> data = {
        'name': _nameController.text,
        'contactNumber': _contactNumberController.text,
        'dateOfBirth': _dateOfBirthController.text,
        'bloodGroup': _bloodGroupController.text,
        'address': _addressController.text,
        'organizationName': _organizationNameController.text,
        'organizationAddress': _organizationAddressController.text,
        'organizationContactNumber': _organizationContactNumberController.text,
        // 'organization_latitude': _organizationLatitudeController.text,
        // 'organization_longitude': _organizationLongitudeController.text,
      };
      ProfileService.uploadProfileDetails(context, data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            BuildBackButton(),
            ProfileDetailsUploadHeader(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: ProfileDetailsFormField(
                nameController: _nameController,
                contactNumberController: _contactNumberController,
                dateOfBirthController: _dateOfBirthController,
                bloodGroupController: _bloodGroupController,
                addressController: _addressController,
                organizationNameController: _organizationNameController,
                organizationAddressController: _organizationAddressController,
                organizationContactNumberController:
                    _organizationContactNumberController,
                // organizationLatitudeController: _organizationLatitudeController,
                // organizationLongitudeController:
                //     _organizationLongitudeController,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22.0),
              padding: const EdgeInsets.only(bottom: 22.0, top: 5.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CustomButton(
                    onPressed: _submitForm,
                    text: 'Submit',
                    color: CustomColor.primaryValue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
