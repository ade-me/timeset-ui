import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/general_app_padding.dart';
import '../../widgets/settings_widgets/custom_switch.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({
    super.key,
    required this.pageController,
  });
  final PageController pageController;

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool accountIsPrivate = false;
  bool suggestAccountToFollow = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (willPop) {
        widget.pageController.jumpTo(0);
      },
      child: SafeArea(
        child: Column(
          children: [
            GeneralAppPadding(
              verticalPadding: 3,
              child: AppBarWithBackButton(
                title: "Privacy",
                hasCustomFunction: true,
                function: () {
                  widget.pageController.jumpTo(0);
                },
              ),
            ),
            SizedBox(
              height: 1.w,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomSwitch(
                      title: "Private Account",
                      onTap: () {
                        setState(() {
                          accountIsPrivate = !accountIsPrivate;
                        });
                      },
                      customIcon: Icons.lock_person_outlined,
                      switchValue: accountIsPrivate,
                      onChange: (val) {
                        setState(() {
                          accountIsPrivate = val;
                        });
                      },
                    ),
                    CustomSwitch(
                      title: "Suggest my account to follow",
                      onTap: () {
                        setState(() {
                          suggestAccountToFollow = !suggestAccountToFollow;
                        });
                      },
                      customIcon: Icons.people_outline_rounded,
                      switchValue: suggestAccountToFollow,
                      onChange: (val) {
                        setState(() {
                          suggestAccountToFollow = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
