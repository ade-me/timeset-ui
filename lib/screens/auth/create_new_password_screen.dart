import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../state_management/auth_provider.dart';
import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/general_app_padding.dart';

class CreateNewPassword extends StatefulWidget {
  static const routeName = '/CreateNewPasswordScreen';

  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  bool passwordHasInput = false;
  bool confirmPasswordHasInput = false;

  void checkPasswordHasInput() =>
      setState(() => passwordTextController.text.isNotEmpty
          ? passwordHasInput = true
          : passwordHasInput = false);

  void checkConfirmPasswordHasInput() =>
      setState(() => confirmPasswordTextController.text.isNotEmpty
          ? confirmPasswordHasInput = true
          : confirmPasswordHasInput = false);

  @override
  void initState() {
    super.initState();

    passwordTextController.addListener(checkPasswordHasInput);
    confirmPasswordTextController.addListener(checkConfirmPasswordHasInput);
  }

  @override
  void dispose() {
    super.dispose();

    passwordTextController.dispose();
    confirmPasswordTextController.dispose();

    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
  }

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 4.h);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: GeneralAppPadding(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 1.h),
                      const AppBarWithBackButton(
                        title: "Create New Password",
                      ),
                      sizedBox,
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/new_password.png",
                          width: 85.w,
                        ),
                      ),
                      SizedBox(height: 7.h),
                      Text(
                        "Create your new password",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      SizedBox(height: 3.h),
                      CustomTextField(
                        textInputType: TextInputType.visiblePassword,
                        controller: passwordTextController,
                        focusNode: passwordFocusNode,
                        iconName: 'password',
                        isPassword: true,
                        hintText: 'Password',
                      ),
                      SizedBox(height: 2.h),
                      CustomTextField(
                        textInputType: TextInputType.visiblePassword,
                        controller: confirmPasswordTextController,
                        focusNode: confirmPasswordFocusNode,
                        iconName: 'password',
                        isPassword: true,
                        hintText: 'Confirm Password',
                      ),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.w),
              child: AuthButton(
                text: 'Continue',
                isDisabled:
                    passwordHasInput && confirmPasswordHasInput ? false : true,
                function: changePassword,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changePassword() async {
    var authPvr = Provider.of<AuthProvider>(context, listen: false);

    await authPvr.changePassword(
      password: passwordTextController.text.trim(),
      confPassword: confirmPasswordTextController.text.trim(),
      context: context,
      scaffoldKey: _scaffoldKey,
    );
  }
}
