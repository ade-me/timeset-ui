import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/auth_widgets/auth_alternate_action_text.dart';
import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/auth_widgets/auth_option_divider.dart';
import '../../widgets/auth_widgets/social_button.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/general_app_padding.dart';
import 'create_account_screen.dart';
import 'login_screen.dart';

class AuthRoot extends StatefulWidget {
  static const routeName = '/AuthRoot';

  const AuthRoot({super.key});

  @override
  State<AuthRoot> createState() => _AuthRootState();
}

class _AuthRootState extends State<AuthRoot> {
  @override
  Widget build(BuildContext context) {
    var textTheme2 = Theme.of(context).textTheme;
    var sizedBox = SizedBox(
      height: 2.h,
    );
    return Scaffold(
      body: SafeArea(
        child: GeneralAppPadding(
          verticalPadding: 2.h,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const AppBarWithBackButton(),
                      Container(
                        margin: EdgeInsets.only(top: 2.h, bottom: 6.h),
                        child: Image.asset(
                          "assets/logos/logo.png",
                          width: 28.w,
                        ),
                      ),
                      Text(
                        "Let's get you in",
                        style: textTheme2.headlineMedium,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.h,
                        ),
                        child: Column(
                          children: [
                            SocialButton(
                              text: "Continue with Facebook",
                              function: () {},
                              icon: "facebook",
                            ),
                            sizedBox,
                            SocialButton(
                              text: "Continue with Google",
                              function: () {},
                              icon: "google",
                            ),
                            sizedBox,
                            SocialButton(
                              text: "Continue with Apple",
                              function: () {},
                              icon: "apple",
                            ),
                            const AuthOptionalDivider(
                              optionText: 'or',
                            ),
                            Column(
                              children: [
                                AuthButton(
                                  text: "Sign in with password",
                                  function: () => Navigator.pushNamed(
                                    context,
                                    LoginScreen.routeName,
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                AuthAlternateActionText(
                                  alternateText: "Don't have an account? ",
                                  actionText: "Sign Up",
                                  function: () => Navigator.pushNamed(
                                    context,
                                    CreateAccountScreen.routeName,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
