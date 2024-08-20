import 'package:flutter/material.dart';
import 'package:idcard/src/widgets/custom_text_form_field.dart';

class ProfileDetailsFormField extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController contactNumberController;
  final TextEditingController dateOfBirthController;
  final TextEditingController bloodGroupController;
  final TextEditingController addressController;
  final TextEditingController organizationNameController;
  final TextEditingController organizationAddressController;
  final TextEditingController organizationContactEmailController;
  final TextEditingController organizationContactNumberController;
  final TextEditingController workingScheduleStart;
  final TextEditingController workingScheduleEnd;
  final TextEditingController organizationLocationLongitude;
  final TextEditingController organizationLocationLatitude;
  // final TextEditingController organizationLatitudeController;
  // final TextEditingController organizationLongitudeController;

  ProfileDetailsFormField({
    required this.nameController,
    required this.contactNumberController,
    required this.dateOfBirthController,
    required this.bloodGroupController,
    required this.addressController,
    required this.organizationNameController,
    required this.organizationAddressController,
    required this.organizationContactNumberController,
    required this.organizationContactEmailController,
    required this.workingScheduleStart,
    required this.workingScheduleEnd,
    required this.organizationLocationLongitude,
    required this.organizationLocationLatitude,
    // required this.organizationLatitudeController,
    // required this.organizationLongitudeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: nameController,
          hintText: 'Name',
          keyboardType: TextInputType.name,
          errorMessage: 'Please enter your Name',
          placeholder: "John Doe",
        ),
        CustomTextFormField(
          controller: contactNumberController,
          hintText: 'Contact Number',
          keyboardType: TextInputType.phone,
          errorMessage: 'Please enter your Contact Number',
          placeholder: "+8801XXXXXXXXX",
        ),
        CustomTextFormField(
          controller: dateOfBirthController,
          hintText: 'Date of Birth',
          keyboardType: TextInputType.datetime,
          errorMessage: 'Please enter your Date of Birth',
          placeholder: "YYYY-MM-DD",
        ),
        CustomTextFormField(
          controller: bloodGroupController,
          hintText: 'Blood Group',
          keyboardType: TextInputType.name,
          errorMessage: 'Please enter your Blood Group',
          placeholder: "A+",
        ),
        CustomTextFormField(
          controller: addressController,
          hintText: 'Address',
          keyboardType: TextInputType.streetAddress,
          errorMessage: 'Please enter your Address',
          placeholder: "Dhaka, Bangladesh",
        ),
        CustomTextFormField(
          controller: organizationNameController,
          hintText: 'Organization Name',
          keyboardType: TextInputType.name,
          errorMessage: 'Please enter your Organization Name',
          placeholder: "ABC Corporation",
        ),
        CustomTextFormField(
          controller: organizationAddressController,
          hintText: 'Organization Address',
          keyboardType: TextInputType.streetAddress,
          errorMessage: 'Please enter your Organization Address',
          placeholder: "Dhaka, Bangladesh",
        ),
        CustomTextFormField(
          controller: organizationContactEmailController,
          hintText: 'Organization Contact Email',
          keyboardType: TextInputType.emailAddress,
          errorMessage: 'Please enter your Organization Contact Email',
          placeholder: "example@abc.com",
        ),
        CustomTextFormField(
          controller: organizationContactNumberController,
          hintText: 'Organization Contact Number',
          keyboardType: TextInputType.phone,
          errorMessage: 'Please enter your Organization Contact Number',
          placeholder: "+8801XXXXXXXXX",
        ),
        CustomTextFormField(
          controller: workingScheduleStart,
          hintText: 'Working Schedule Start',
          keyboardType: TextInputType.datetime,
          errorMessage: 'Please enter your Working Schedule Start',
          placeholder: "HH:MM",
        ),
        CustomTextFormField(
          controller: workingScheduleEnd,
          hintText: 'Working Schedule End',
          keyboardType: TextInputType.datetime,
          errorMessage: 'Please enter your Working Schedule End',
          placeholder: "HH:MM",
        ),
        CustomTextFormField(
          controller: organizationLocationLongitude,
          hintText: 'Organization Location Longitude',
          keyboardType: TextInputType.number,
          errorMessage: 'Please enter your Organization Location Logitude',
          placeholder: "90.407143 [not updatable]",
        ),
        CustomTextFormField(
          controller: organizationLocationLatitude,
          hintText: 'Organization Location Latitude',
          keyboardType: TextInputType.number,
          errorMessage: 'Please enter your Organization Location Latitude',
          placeholder: "23.585832 [not updatable]",
        ),
        // CustomTextFormField(
        //   controller: organizationLatitudeController,
        //   hintText: 'Organization Latitude',
        //   keyboardType: TextInputType.number,
        //   errorMessage: 'Please enter your Organization Latitude',
        //   placeholder: "90.407143",
        // ),
        // CustomTextFormField(
        //   controller: organizationLongitudeController,
        //   hintText: 'Organization Longitude',
        //   keyboardType: TextInputType.number,
        //   errorMessage: 'Please enter your Organization Longitude',
        //   placeholder: "23.585832",
        // ),
      ],
    );
  }
}
