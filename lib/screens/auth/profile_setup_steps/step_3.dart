import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../../widgets/general_widgets/general_app_padding.dart';

class Step3 extends StatefulWidget {
  const Step3(
      {super.key,
      required this.goBack,
      required this.dateOfBirth,
      required this.getDateOfBirth});

  final Function() goBack;
  final DateTime dateOfBirth;
  final Function(DateTime) getDateOfBirth;

  @override
  State<Step3> createState() => _Step3State();
}

class _Step3State extends State<Step3> {
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
              title: "When is your birthday?",
            ),
            Text(
              'Your birthday will not be shown to the public',
              style: textTheme.bodySmall,
            ),
            sizedBox,
            sizedBox,
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/images/birthday.svg',
                width: 55.w,
              ),
            ),
            sizedBox,
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15.sp,
                vertical: 12.sp,
              ),
              decoration: BoxDecoration(
                color: HexColor("#222222"),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: HexColor("#2C2C2C"),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.dateOfBirth.month}/${widget.dateOfBirth.day}/${widget.dateOfBirth.year}",
                  ),
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40.h,
              width: 100.w,
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontFamily: "pjs",
                    ),
                  ),
                ),
                child: CupertinoDatePicker(
                  itemExtent: 50,
                  initialDateTime: widget.dateOfBirth,
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime newDate) {
                    widget.getDateOfBirth(newDate);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
