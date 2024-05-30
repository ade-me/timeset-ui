import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/general_app_padding.dart';
import '../../widgets/settings_widgets/custom_switch.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({
    super.key,
    required this.pageController,
  });
  final PageController pageController;

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool rememberMe = false;
  bool biometric = false;
  bool faceID = false;

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
                title: "Security",
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
                      title: "Remember Me",
                      onTap: () {
                        setState(() {
                          rememberMe = !rememberMe;
                        });
                      },
                      customIcon: Icons.remember_me_outlined,
                      switchValue: rememberMe,
                      onChange: (val) {
                        setState(() {
                          rememberMe = val;
                        });
                      },
                    ),
                    Visibility(
                      visible: !Platform.isIOS,
                      child: CustomSwitch(
                        title: "Biometric ID",
                        onTap: () {
                          setState(() {
                            biometric = !biometric;
                          });
                        },
                        customIcon: Icons.fingerprint_rounded,
                        switchValue: biometric,
                        onChange: (val) {
                          setState(() {
                            biometric = val;
                          });
                        },
                      ),
                    ),
                    CustomSwitch(
                      title: "Face ID",
                      onTap: () {
                        setState(() {
                          faceID = !faceID;
                        });
                      },
                      customIcon: Icons.face_outlined,
                      switchValue: faceID,
                      onChange: (val) {
                        setState(() {
                          faceID = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    GeneralAppPadding(
                      child: AuthButton(
                        color: "#9CBB30",
                        borderColor: "#9CBB30",
                        text: "Reset Password",
                        bgColor: "#141414",
                        function: () {},
                      ),
                    )
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
