import 'package:flutter/material.dart';

import '../settings_screens/edit_phonenumber_screen.dart';
import '../settings_screens/manage_account_screen.dart';
import '../settings_screens/report_problem_screen.dart';
import './language_screen.dart';
import './privacy_screen.dart';
import './qr_code_screen.dart';
import './security_screen.dart';
import './settings_screen.dart';

class SettingsRoot extends StatefulWidget {
  static const routeName = "/SettingScreen";
  const SettingsRoot({super.key});

  @override
  State<SettingsRoot> createState() => _SettingsRootState();
}

class _SettingsRootState extends State<SettingsRoot> {
  final pageController = PageController();

  int currentIndex = 0;

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      SettingsScreen(pageController: pageController),
      PrivacyScreen(pageController: pageController),
      SecurityScreen(pageController: pageController),
      QRCodeScreen(pageController: pageController),
      LanguageScreen(pageController: pageController),
      ReportProblemScreen(pageController: pageController),
      ManageAccountScreen(pageController: pageController),
      EditPhoneNumberScreen(pageController: pageController)
    ];
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: pages,
        onPageChanged: (index) => setState(() {
          currentIndex = index;
        }),
      ),
    );
  }
}
