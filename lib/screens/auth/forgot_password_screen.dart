import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/replace_chars.dart';
import '../../state_management/auth_provider.dart';
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
  String selectedUserDetail = "email";
  bool isEnterOTP = false;
  int currentPage = 0;

  void checkEmailHasInput() => setState(
        () => emailTextController.text.isNotEmpty
            ? emailHasInput = true
            : emailHasInput = false,
      );

  void checkOTPHasInput() => setState(
        () => otpTextController.text.length == 6
            ? otpHasInput = true
            : otpHasInput = false,
      );

  void onSelection(String text) {
    setState(() => selectedUserDetail = text);
  }

  void updateUserDetails() async {
    var authPvr = Provider.of<AuthProvider>(context, listen: false);

    await authPvr.findUserWithEmail(
      email: emailTextController.text.trim(),
      nextPage: nextPage,
      context: context,
      scaffoldKey: _scaffoldKey,
    );
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

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 4.h);

    return Scaffold(
      body: ScaffoldMessenger(
        key: _scaffoldKey,
        child: SafeArea(
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
                            Consumer<AuthProvider>(
                              builder: (context, authPvr, child) {
                                Map<String, dynamic> userDetails =
                                    authPvr.forgottenUserDetails ?? {};

                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        onSelection("phone");
                                      },
                                      child: ContactDetailSelect(
                                        via: "SMS",
                                        text: userDetails["phone"].toString(),
                                        isSelected:
                                            selectedUserDetail == "phone"
                                                ? true
                                                : false,
                                      ),
                                    ),
                                    child!,
                                    GestureDetector(
                                      onTap: () {
                                        onSelection("email");
                                      },
                                      child: ContactDetailSelect(
                                        via: "Email",
                                        text: userDetails["email"].toString(),
                                        isSelected:
                                            selectedUserDetail == "email"
                                                ? true
                                                : false,
                                      ),
                                    ),
                                  ],
                                );
                              },
                              child: SizedBox(
                                height: 2.h,
                              ),
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
                                Consumer<AuthProvider>(
                                    builder: (context, authPvr, _) {
                                  Map<String, dynamic> userDetails =
                                      authPvr.forgottenUserDetails ?? {};

                                  return Text(
                                    "A code has been sent to ${selectedUserDetail == "email" ? replaceEmail(userDetails[selectedUserDetail]) : replacePhone(userDetails[selectedUserDetail])}",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                    ),
                                  );
                                }),
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
                        ? {updateUserDetails()}
                        : currentPage == 2
                            ? verifyOtpCode()
                            : sendVerificationCode();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendVerificationCode() async {
    var authPvr = Provider.of<AuthProvider>(context, listen: false);

    Map<String, dynamic> data = {};

    switch (selectedUserDetail) {
      case 'email':
        data = {
          'email': authPvr.forgottenUserDetails?['email'] ?? '',
        };
        break;
      default:
        data = {
          'phone': authPvr.forgottenUserDetails?['number'] ?? '',
        };
        break;
    }

    await authPvr.sendVeriCode(
      data: data,
      nextPage: nextPage,
      context: context,
      scaffoldKey: _scaffoldKey,
    );
  }

  void verifyOtpCode() async {
    var authPvr = Provider.of<AuthProvider>(context, listen: false);

    Map<String, dynamic> data = {};

    switch (selectedUserDetail) {
      case 'email':
        data = {
          'email': authPvr.forgottenUserDetails?['email'] ?? '',
          'pin': int.parse(otpTextController.text.trim()),
        };
        break;
      default:
        data = {
          'phone': authPvr.forgottenUserDetails?['number'] ?? '',
          'pin': int.parse(otpTextController.text.trim()),
        };
        break;
    }

    await authPvr.verifyOtp(
      data: data,
      context: context,
      scaffoldKey: _scaffoldKey,
    );
  }
}
