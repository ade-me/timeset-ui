import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class CustomHomeAppBarChip extends StatelessWidget {
  const CustomHomeAppBarChip(
      {super.key,
      required this.text,
      this.isSelected = false,
      required this.iconUrl});

  final String text;
  final bool isSelected;
  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.sp,
        vertical: 7.sp,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? HexColor("#000000")
            : !isSelected && text == "Discover"
                ? HexColor("#FF3131")
                : HexColor("#000000").withOpacity(0.4),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: HexColor("#ffffff").withOpacity(0.3),
          width: 0.3.sp,
        ),
      ),
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
    );
  }
}
