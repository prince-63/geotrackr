import 'package:flutter/material.dart';
import 'package:idcard/src/model/user.dart';
import 'package:idcard/src/screens/profile/profile_create/profile_image/widgets/profile_action_button.dart';
import 'package:idcard/src/screens/profile/widgets/action_button.dart';
import 'package:idcard/src/screens/profile/widgets/custom_display_text_field.dart';
import 'package:idcard/src/screens/profile/widgets/custom_icon_button.dart';
import 'package:idcard/src/screens/profile/widgets/profile_header.dart';
import 'package:idcard/src/screens/profile/widgets/profile_information.dart';
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
          : RefreshIndicator(
              onRefresh: fetchUserData,
              child: SingleChildScrollView(
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
                            profileImageUrl:
                                userData?['profilePictureUrl'] ?? '',
                            username: userData?['username'] ?? 'N/A',
                            name: userData?['name'] ?? 'N/A',
                          ),
                        ],
                      ),
                    ),

                    // Information Section
                    ProfileInformation(userData: userData),

                    // profile button
                    ProfileButtons(),

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
            ),
    );
  }
}
