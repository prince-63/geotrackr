import 'package:flutter/material.dart';
import 'package:geotrackr/presentation/widgets/custom_button.dart';
import 'package:geotrackr/presentation/widgets/custom_expansion_card.dart';
import 'package:geotrackr/presentation/widgets/default_app_bar.dart';
import 'package:geotrackr/utils/custom_color.dart';
import 'package:url_launcher/url_launcher.dart';

/// The [HelpAndSupportPage] widget is a stateless widget that represents the help and support page of the application.
/// It provides various options for contacting support and includes a list of frequently asked questions (FAQs).
class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  /// Launches a URL using the default external application.
  /// This method is used to open email, website, phone, and chat links.
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDarkMode ? CustomColor.darkTextColor : CustomColor.lightTextColor;
    final backgroundColor = isDarkMode
        ? CustomColor.darkBackgroundColor
        : CustomColor.lightBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: DefaultAppBar(
        title: 'Help & Support',
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.help_outline,
                      size: 100,
                      color: textColor,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Help & Support',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Need help? Contact us at',
                      style: TextStyle(
                        fontSize: 18,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: 'Email us',
                        onPressed: () {
                          _launchURL('mailto:prince08833@gmail.com');
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: 'Visit our website',
                        onPressed: () {
                          _launchURL('https://geotrackr.tech');
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: 'Call us',
                        onPressed: () {
                          _launchURL('tel:6289296197');
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: 'Chat with us',
                        onPressed: () {
                          _launchURL('whatsapp://send?phone=6289296197');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 10),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  CustomExpansionCard(
                    title: 'How to reset my password?',
                    content: 'To reset your password, follow these steps:\n\n'
                        '1. Go to the login page.\n'
                        '2. Click on "Forgot Password".\n'
                        '3. Enter your registered email address.\n'
                        '4. Check your email for verification code.\n'
                        '5. Enter your verification code.\n'
                        '6. Enter your new password.\n'
                        '7. Click "Save" to apply the changes.',
                    leadingIcon: Icons.question_answer,
                    textColor: textColor,
                    isDarkMode: isDarkMode,
                    backgroundColor: backgroundColor,
                  ),
                  CustomExpansionCard(
                    title: 'How to update my profile?',
                    content: 'To update your profile, follow these steps:\n\n'
                        '1. Go to the profile page.\n'
                        '2. Click on "Edit Profile".\n'
                        '3. Update your information.\n'
                        '4. Click "Save" to apply the changes.',
                    leadingIcon: Icons.question_answer,
                    textColor: textColor,
                    isDarkMode: isDarkMode,
                    backgroundColor: backgroundColor,
                  ),
                  // Add more CustomExpansionCard widgets for additional FAQs
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
