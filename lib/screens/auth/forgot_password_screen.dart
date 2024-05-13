import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/helpers/replace_chars.dart';
import 'package:timeset/screens/auth/create_new_password_screen.dart';

import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/auth_widgets/contact_detail_select.dart';
import '../../widgets/auth_widgets/otp_textfield.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/general_app_padding.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgotPasswordScreen';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailTextController = TextEditingController();
  final otpTextController = TextEditingController();

  final emailFocusNode = FocusNode();
  final otpFocusNode = FocusNode();

  bool emailHasInput = false;
  bool otpHasInput = false;
  Map<String, dynamic> userDetails = {};
  String selectedUserDetail = "";
  bool isEnterOTP = false;

  void checkEmailHasInput() => setState(
        () => emailTextController.text.isNotEmpty
            ? emailHasInput = true
            : emailHasInput = false,
      );

  void checkOTPHasInput() => setState(
        () => otpTextController.text.length == 4
            ? otpHasInput = true
            : otpHasInput = false,
      );

  void onSelection(String text) {
    setState(() => selectedUserDetail = text);
  }

  void updateUserDetails() {
    setState(() => userDetails = {
          "email": emailTextController.text,
          "phone": "+2348095789263"
        });
  }

  @override
  void initState() {
    super.initState();

    emailTextController.addListener(checkEmailHasInput);
    otpTextController.addListener(checkOTPHasInput);
  }

  @override
  void dispose() {
    super.dispose();

    emailTextController.dispose();
    otpTextController.dispose();

    emailFocusNode.dispose();
    otpFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 4.h);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: GeneralAppPadding(
                  child: isEnterOTP
                      ? Column(
                          children: [
                            SizedBox(height: 1.h),
                            const AppBarWithBackButton(
                              title: "Forgot Password",
                            ),
                            sizedBox,
                            Column(
                              children: [
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                  "A code has been sent to ${selectedUserDetail == "email" ? replaceEmail(userDetails[selectedUserDetail]) : replacePhone(userDetails[selectedUserDetail])}",
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                OTPTextField(
                                  pinController: otpTextController,
                                  focusNode: otpFocusNode,
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: "Resend code in ",
                                      ),
                                      TextSpan(
                                        text: "5 ",
                                        style: TextStyle(
                                          color: HexColor("#9CBB30"),
                                        ),
                                      ),
                                      const TextSpan(
                                        text: "s",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.h),
                            const AppBarWithBackButton(
                              title: "Forgot Password",
                            ),
                            sizedBox,
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/images/forgot1.png",
                                width: 85.w,
                              ),
                            ),
                            SizedBox(height: 7.h),
                            Text(
                              userDetails.isEmpty
                                  ? "Enter your email so we can find your account"
                                  : "Select which contact details we should use to reset your password",
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            SizedBox(height: 3.h),
                            userDetails.isEmpty
                                ? CustomTextField(
                                    textInputType: TextInputType.emailAddress,
                                    controller: emailTextController,
                                    focusNode: emailFocusNode,
                                    iconName: 'email',
                                    hintText: 'Email',
                                  )
                                : Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          onSelection("phone");
                                        },
                                        child: ContactDetailSelect(
                                          via: "SMS",
                                          text: userDetails["phone"],
                                          isSelected:
                                              selectedUserDetail == "phone"
                                                  ? true
                                                  : false,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          onSelection("email");
                                        },
                                        child: ContactDetailSelect(
                                          via: "Email",
                                          text: userDetails["email"],
                                          isSelected:
                                              selectedUserDetail == "email"
                                                  ? true
                                                  : false,
                                        ),
                                      ),
                                    ],
                                  ),
                            SizedBox(height: 3.h),
                          ],
                        ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.w),
              child: isEnterOTP
                  ? AuthButton(
                      text: 'Verify',
                      isDisabled: otpHasInput ? false : true,
                      function: () => Navigator.pushReplacementNamed(
                        context,
                        CreateNewPassword.routeName,
                      ),
                    )
                  : userDetails.isEmpty
                      ? AuthButton(
                          text: 'Continue',
                          isDisabled: emailHasInput ? false : true,
                          function: () {
                            updateUserDetails();
                          },
                        )
                      : AuthButton(
                          text: 'Continue',
                          isDisabled:
                              selectedUserDetail.isNotEmpty ? false : true,
                          function: () {
                            setState(
                              () {
                                isEnterOTP = true;
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
