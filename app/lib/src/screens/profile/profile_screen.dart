import 'package:flutter/material.dart';
import 'package:idcard/src/model/user.dart';
import 'package:idcard/src/screens/profile/widgets/custom_display_text_field.dart';
import 'package:idcard/src/screens/profile/widgets/custom_icon_button.dart';
import 'package:idcard/src/screens/profile/widgets/profile_header.dart';
import 'package:idcard/src/services/logout/logout_service.dart';
import 'package:idcard/src/services/profile/profile_service.dart';
import 'package:idcard/src/utils/custom_color.dart';
import 'package:idcard/src/widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User user;
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final data = await ProfileService.getUserProfile(context);

      if (data != null && data['status'] == 'success') {
        setState(() {
          this.userData = data['data'];
          isLoading = false;
        });
        print(userData);
        print('User data loaded successfully');
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load user data');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Failed to load user data: $error');
    }
  }

  void _logout() async {
    await LogoutService.logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.profileFillColor,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: CustomColor.profileBoxColor,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ProfileHeader(
                          profileImageUrl: userData?['profilePictureUrl'] ?? '',
                          username: userData?['username'] ?? 'N/A',
                          name: userData?['name'] ?? 'N/A',
                        ),
                      ],
                    ),
                  ),

                  // Information Section
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: CustomColor.profileBoxColor,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.all(4.0),
                            child: Text(
                              "Information",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                CustomDisplayTextField(
                                  label: "Email",
                                  value: userData?['email'] ?? 'N/A',
                                  icon: Icons.email,
                                ),
                                CustomDisplayTextField(
                                  label: "Phone",
                                  value: userData?['contactNumber'] ?? 'N/A',
                                  icon: Icons.phone,
                                ),
                                CustomDisplayTextField(
                                  label: "Date of Birth",
                                  value: userData?['dateOfBirth'] ?? 'N/A',
                                  icon: Icons.calendar_today,
                                ),
                                CustomDisplayTextField(
                                  label: "Blood Group",
                                  value: userData?['bloodGroup'] ?? 'N/A',
                                  icon: Icons.local_hospital,
                                ),
                                CustomDisplayTextField(
                                  label: "Address",
                                  value: userData?['address'] ?? 'N/A',
                                  icon: Icons.location_on,
                                ),
                                CustomDisplayTextField(
                                  label: "Organization Name",
                                  value: userData?['organizationName'] ?? 'N/A',
                                  icon: Icons.business,
                                ),
                                CustomDisplayTextField(
                                  label: "Organization Email",
                                  value:
                                      userData?['organizationContactEmail'] ??
                                          'N/A',
                                  icon: Icons.email,
                                ),
                                CustomDisplayTextField(
                                  label: "Organisation Address",
                                  value:
                                      userData?['organizationAddress'] ?? 'N/A',
                                  icon: Icons.location_city,
                                ),
                                CustomDisplayTextField(
                                  label: "Organisation Phone",
                                  value:
                                      userData?['organizationContactNumber'] ??
                                          'N/A',
                                  icon: Icons.phone,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // Buttons Section
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: CustomColor.profileBoxColor,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            CustomIconButton(
                              text: "View & Download",
                              leadingIcon: Icons.download,
                              trailingIcon: Icons.arrow_forward_ios,
                              onPressed: () {
                                Navigator.pushNamed(context, '#');
                              },
                            ),
                            CustomIconButton(
                              text: "Update Information",
                              leadingIcon: Icons.edit,
                              trailingIcon: Icons.arrow_forward_ios,
                              onPressed: () {
                                Navigator.pushNamed(context, '#');
                              },
                            ),
                            CustomIconButton(
                              text: "Account",
                              leadingIcon: Icons.account_circle,
                              trailingIcon: Icons.arrow_forward_ios,
                              onPressed: () {
                                Navigator.pushNamed(context, '#');
                              },
                            ),
                            CustomIconButton(
                              text: "Help & Support",
                              leadingIcon: Icons.help,
                              trailingIcon: Icons.arrow_forward_ios,
                              onPressed: () {
                                Navigator.pushNamed(context, '#');
                              },
                            ),
                            CustomIconButton(
                              text: "About",
                              leadingIcon: Icons.info,
                              trailingIcon: Icons.arrow_forward_ios,
                              onPressed: () {
                                Navigator.pushNamed(context, '#');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Logout Button
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(3.0),
                    child: CustomButton(
                      onPressed: _logout,
                      text: "Logout",
                      color: const Color.fromARGB(255, 255, 38, 0),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
