import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/widgets/auth_widgets/auth_button.dart';
import 'package:timeset/widgets/general_widgets/app_bar_with_back_button.dart';
import 'package:timeset/widgets/auth_widgets/social_button.dart';

class AuthRoot extends StatefulWidget {
  static const routeName = '/AuthRoot';

  const AuthRoot({super.key});

  @override
  State<AuthRoot> createState() => _AuthRootState();
}

class _AuthRootState extends State<AuthRoot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: AppBarWithBackButton(),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 60),
                      child: Image.asset(
                        "assets/logos/logo.png",
                        width: 28.w,
                      ),
                    ),
                    const Text(
                      "Let's get you in",
                      style: TextStyle(
                        fontFamily: "pjs-semi-bold",
                        fontSize: 33,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 30,
                      ),
                      child: Column(
                        children: [
                          SocialButton(
                            text: "Continue with Facebook",
                            function: () {},
                            image: "assets/icons/facebook.png",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SocialButton(
                            text: "Continue with Google",
                            function: () {},
                            image: "assets/icons/google.png",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SocialButton(
                            text: "Continue with Apple",
                            function: () {},
                            image: "assets/icons/apple.png",
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    color: HexColor("#2C2C2C"),
                                    height: 1.0,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                  ),
                                  child: Text(
                                    'or',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    color: HexColor("#2C2C2C"),
                                    height: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: Column(
                              children: [
                                AuthButton(
                                  text: "Sign in with password",
                                  function: () {},
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don't have an account?",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: HexColor(
                                            "#9CBB30",
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
