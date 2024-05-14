import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({super.key, required this.text, this.isSelected = false});

  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14.sp,
        vertical: 7.sp,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? HexColor("#9CBB30")
            : HexColor("#000000").withOpacity(0.4),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isSelected
              ? HexColor("#9CBB30")
              : HexColor("#ffffff").withOpacity(0.3),
          width: 0.4.sp,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? HexColor("#141414") : HexColor("#ffffff"),
          fontWeight: FontWeight.w500,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
