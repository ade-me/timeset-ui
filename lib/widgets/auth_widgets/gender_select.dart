import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class GenderSelect extends StatelessWidget {
  const GenderSelect({super.key, this.isMale = true, this.isSelected = false});

  final bool isMale;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? HexColor("#9CBB30") : HexColor("#2C2C2C"),
        borderRadius: BorderRadius.circular(40.w),
      ),
      width: 40.w,
      height: 40.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isMale ? Icons.male : Icons.female,
            size: 14.w,
            color: isSelected ? HexColor("#141414") : Colors.white,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            isMale ? "Male" : "Female",
            style: TextStyle(
              color: isSelected ? HexColor("#141414") : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
