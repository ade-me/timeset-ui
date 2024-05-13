import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'auth_option_divider.dart';
import 'social_icons_button.dart';

class AuthSocialOptions extends StatelessWidget {
  const AuthSocialOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: const AuthOptionalDivider(
            optionText: 'or continue with',
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialIconButton(
              icon: 'facebook',
            ),
            SocialIconButton(
              icon: 'google',
            ),
            SocialIconButton(
              icon: 'apple',
            ),
          ],
        ),
        SizedBox(height: 5.h),
      ],
    );
  }
}
