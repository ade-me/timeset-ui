import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/screens/auth/fill_profile_screen.dart';

import '../../widgets/auth_widgets/auth_alternate_action_text.dart';
import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/auth_widgets/auth_social_options.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/general_app_padding.dart';
import 'login_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  static const routeName = '/CreateAccountScreen';

  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
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
                        'Create Your Account',
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
                        text: 'Sign Up',
                        isDisabled:
                            emailHasInput && passwordHasInput ? false : true,
                        function: () => Navigator.pushNamed(
                          context,
                          FillProfileScreen.routeName,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const AuthSocialOptions(),
            AuthAlternateActionText(
              alternateText: 'Already have an account? ',
              actionText: 'Sign In',
              function: () => Navigator.pushNamed(
                context,
                LoginScreen.routeName,
              ),
            ),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
}
