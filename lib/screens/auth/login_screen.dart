import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../screens/auth/forgot_password_screen.dart';
import '../../widgets/auth_widgets/auth_alternate_action_text.dart';
import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/auth_widgets/auth_social_options.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/general_app_padding.dart';
import 'create_account_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool emailHasInput = false;
  bool passwordHasInput = false;

  void checkEmailHasInput() =>
      setState(() => emailTextController.text.isNotEmpty
          ? emailHasInput = true
          : emailHasInput = false);

  void checkPasswordHasInput() =>
      setState(() => passwordTextController.text.isNotEmpty
          ? passwordHasInput = true
          : passwordHasInput = false);

  @override
  void initState() {
    super.initState();

    emailTextController.addListener(checkEmailHasInput);
    passwordTextController.addListener(checkPasswordHasInput);
  }

  @override
  void dispose() {
    super.dispose();

    emailTextController.dispose();
    passwordTextController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 4.h);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      const AppBarWithBackButton(),
                      sizedBox,
                      Text(
                        'Login to Your Account',
                        style: textTheme.headlineMedium,
                      ),
                      sizedBox,
                      CustomTextField(
                        textInputType: TextInputType.emailAddress,
                        controller: emailTextController,
                        focusNode: emailFocusNode,
                        iconName: 'email',
                        hintText: 'Email',
                      ),
                      SizedBox(height: 2.h),
                      CustomTextField(
                        textInputType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        controller: passwordTextController,
                        focusNode: passwordFocusNode,
                        iconName: 'password',
                        hintText: 'Password',
                        isPassword: true,
                      ),
                      SizedBox(height: 3.h),
                      AuthButton(
                        text: 'Sign In',
                        isDisabled:
                            emailHasInput && passwordHasInput ? false : true,
                        function: () {},
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pushReplacementNamed(
                              context,
                              ForgotPasswordScreen.routeName,
                            ),
                            child: Text(
                              'Forgot your password?',
                              style: TextStyle(
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const AuthSocialOptions(),
            AuthAlternateActionText(
              alternateText: 'Don\'t have an account? ',
              actionText: 'Sign Up',
              function: () => Navigator.pushReplacementNamed(
                context,
                CreateAccountScreen.routeName,
              ),
            ),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
}
