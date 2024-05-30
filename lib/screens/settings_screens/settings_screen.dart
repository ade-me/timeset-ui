import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/create_post_widgets/options_tile.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/general_app_padding.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.pageController,
  });
  final PageController pageController;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const GeneralAppPadding(
            verticalPadding: 3,
            child: AppBarWithBackButton(
              title: "Settings",
            ),
          ),
          SizedBox(
            height: 1.w,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  OptionsTile(
                    title: "Manage Account",
                    hasCustomIcon: true,
                    customIcon: Icons.account_circle_outlined,
                    onTap: () {
                      widget.pageController.jumpToPage(
                        6,
                      );
                    },
                  ),
                  OptionsTile(
                    title: "Privacy",
                    hasCustomIcon: true,
                    customIcon: Icons.privacy_tip_outlined,
                    onTap: () {
                      widget.pageController.jumpToPage(
                        1,
                      );
                    },
                  ),
                  OptionsTile(
                    title: "Security",
                    hasCustomIcon: true,
                    customIcon: Icons.security_rounded,
                    onTap: () {
                      widget.pageController.jumpToPage(
                        2,
                      );
                    },
                  ),
                  OptionsTile(
                    title: "QR Code",
                    hasCustomIcon: true,
                    customIcon: Icons.qr_code_rounded,
                    onTap: () {
                      widget.pageController.jumpToPage(
                        3,
                      );
                    },
                  ),
                  OptionsTile(
                    title: "Language",
                    hasCustomIcon: true,
                    customIcon: Icons.language_rounded,
                    onTap: () {
                      widget.pageController.jumpToPage(
                        4,
                      );
                    },
                  ),
                  OptionsTile(
                    title: "Report a Problem",
                    hasCustomIcon: true,
                    customIcon: Icons.report_outlined,
                    onTap: () {
                      widget.pageController.jumpToPage(
                        5,
                      );
                    },
                  ),
                  OptionsTile(
                    title: "Help",
                    hasCustomIcon: true,
                    customIcon: Icons.help_outline_rounded,
                    onTap: () {
                      // widget.pageController.jumpToPage(
                      //   3,
                      // );
                    },
                  ),
                  OptionsTile(
                    title: "Community Guidelines",
                    hasCustomIcon: true,
                    customIcon: Icons.rule_rounded,
                    onTap: () {
                      // widget.pageController.jumpToPage(
                      //   3,
                      // );
                    },
                  ),
                  OptionsTile(
                    title: "Terms of Services",
                    hasCustomIcon: true,
                    customIcon: Icons.file_open_outlined,
                    onTap: () {
                      // widget.pageController.jumpToPage(
                      //   3,
                      // );
                    },
                  ),
                  OptionsTile(
                    title: "Privacy Policy",
                    hasCustomIcon: true,
                    customIcon: Icons.privacy_tip_outlined,
                    onTap: () {
                      // widget.pageController.jumpToPage(
                      //   3,
                      // );
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 50.w,
            padding: EdgeInsets.all(15.sp),
            child: AuthButton(
              grayButton: true,
              bgColor: "#141414",
              text: "Logout",
              color: "#FF3131",
              hasCustomIcon: true,
              customIcon: Icons.logout_rounded,
              function: () {},
            ),
          )
        ],
      ),
    );
  }
}
