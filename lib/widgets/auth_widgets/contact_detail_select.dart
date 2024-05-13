import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/replace_chars.dart';

class ContactDetailSelect extends StatelessWidget {
  const ContactDetailSelect({
    super.key,
    required this.via,
    required this.text,
    required this.isSelected,
  });

  final String via;
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: isSelected
            ? Border.all(
                color: HexColor("9CBB30"),
              )
            : null,
        color: isSelected
            ? HexColor("#9CBB30").withOpacity(0.05)
            : HexColor("#2C2C2C"),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15.sp,
        vertical: 13.sp,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(9.sp),
            decoration: BoxDecoration(
              color: isSelected ? HexColor("#2C2C2C") : HexColor("#232323"),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              via == "Email" ? Icons.mail_rounded : Icons.sms_rounded,
              color: HexColor("#9CBB30"),
              size: 13.sp,
            ),
          ),
          SizedBox(
            width: 4.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "via $via",
                style: TextStyle(
                  fontSize: 9.sp,
                  color: HexColor("#AEAEAE"),
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Text(
                via == "SMS" ? replacePhone(text) : replaceEmail(text),
                style: TextStyle(
                  fontSize: 11.sp,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
