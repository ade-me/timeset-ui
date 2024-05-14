import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/replace_chars.dart';
import '../../screens/auth/create_new_password_screen.dart';
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
  final pageViewController = PageController();

  final emailFocusNode = FocusNode();
  final otpFocusNode = FocusNode();

  bool emailHasInput = false;
  bool otpHasInput = false;
  Map<String, dynamic> userDetails = {"phone": "", "email": ""};
  String selectedUserDetail = "email";
  bool isEnterOTP = false;
  int currentPage = 0;

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

  void handlePageViewChanged(int currentPageIndex) {
    setState(() {
      currentPage = currentPageIndex;
    });
  }

  void goBack() {
    pageViewController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCirc,
    );
  }

  void nextPage() {
    pageViewController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCirc,
    );
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
    pageViewController.dispose();

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
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageViewController,
                onPageChanged: handlePageViewChanged,
                children: [
                  SingleChildScrollView(
                    child: GeneralAppPadding(
                      child: Column(
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
                            "Enter your email so we can find your account",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          SizedBox(height: 3.h),
                          CustomTextField(
                            textInputType: TextInputType.emailAddress,
                            controller: emailTextController,
                            focusNode: emailFocusNode,
                            iconName: 'email',
                            hintText: 'Email',
                          ),
                          SizedBox(height: 3.h),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: GeneralAppPadding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          AppBarWithBackButton(
                            title: "Forgot Password",
                            hasCustomFunction: true,
                            function: () {
                              goBack();
                            },
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
                            "Select which contact details we should use to reset your password",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          SizedBox(height: 3.h),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  onSelection("phone");
                                },
                                child: ContactDetailSelect(
                                  via: "SMS",
                                  text: userDetails["phone"],
                                  isSelected: selectedUserDetail == "phone"
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
                                  isSelected: selectedUserDetail == "email"
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
                  SingleChildScrollView(
                    child: GeneralAppPadding(
                      child: Column(
                        children: [
                          SizedBox(height: 1.h),
                          AppBarWithBackButton(
                            title: "Forgot Password",
                            hasCustomFunction: true,
                            function: () {
                              goBack();
                            },
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
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.w),
              child: AuthButton(
                text: currentPage == 2 ? "Verify" : 'Continue',
                isDisabled: currentPage == 0 && !emailHasInput
                    ? true
                    : currentPage == 1 && selectedUserDetail.isEmpty
                        ? true
                        : currentPage == 2 && !otpHasInput
                            ? true
                            : false,
                function: () {
                  currentPage == 0
                      ? {updateUserDetails(), nextPage()}
                      : currentPage == 2
                          ? {
                              Navigator.pushReplacementNamed(
                                context,
                                CreateNewPassword.routeName,
                              ),
                            }
                          : nextPage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
