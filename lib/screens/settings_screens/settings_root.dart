import 'package:flutter/material.dart';
import 'package:timeset/screens/settings_screens/settings_screen.dart';

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
