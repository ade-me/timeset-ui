import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../models/gender.dart';
import '../../../widgets/auth_widgets/gender_select.dart';
import '../../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../../widgets/general_widgets/general_app_padding.dart';

class Step2 extends StatefulWidget {
  const Step2({
    super.key,
    required this.getGender,
    required this.goBack,
    required this.gender,
  });

  final Function(Gender) getGender;
  final Function() goBack;
  final Gender gender;

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 4.h);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return SingleChildScrollView(
      child: GeneralAppPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.h),
            AppBarWithBackButton(
              hasCustomFunction: true,
              function: () {
                widget.goBack();
              },
              title: "Tell us about yourself",
            ),
            Text(
              'Choose your identity and help us find accurate contents for you',
              style: textTheme.bodySmall,
            ),
            sizedBox,
            sizedBox,
            SizedBox(
              width: 100.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.getGender(Gender.male);
                    },
                    child: GenderSelect(
                      isSelected: widget.gender == Gender.male ? true : false,
                    ),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.getGender(Gender.female);
                    },
                    child: GenderSelect(
                      isMale: false,
                      isSelected: widget.gender == Gender.female ? true : false,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
