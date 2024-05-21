// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class CustomHomeAppBarChip extends StatelessWidget {
  const CustomHomeAppBarChip({
    super.key,
    required this.text,
    this.isSelected = false,
    required this.iconUrl,
    this.onTap,
  });

  final String text;
  final bool isSelected;
  final String iconUrl;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(30);
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white10,
      borderRadius: borderRadius,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: 1.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: HexColor("#ffffff").withOpacity(0.3),
            width: 0.3.sp,
          ),
          color: isSelected
              ? HexColor("#000000")
              : HexColor("#000000").withOpacity(0.4),
        ),
        margin: EdgeInsets.only(right: 3.w),
        child: Row(
          children: [
            SvgPicture.asset(
              iconUrl,
              color: isSelected ? HexColor("#9CBB30") : HexColor("#ffffff"),
            ),
            SizedBox(
              width: 5.sp,
            ),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? HexColor("#9CBB30") : HexColor("#ffffff"),
                fontWeight: FontWeight.w500,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
