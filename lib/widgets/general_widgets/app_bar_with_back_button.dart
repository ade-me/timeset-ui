import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class AppBarWithBackButton extends StatelessWidget {
  const AppBarWithBackButton({
    super.key,
    this.title = "",
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: Stack(
        children: [
          // back button
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () => Navigator.of(context).pop(),
                splashColor: Colors.white10,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: HexColor("#2C2C2C"), width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.all(9.sp),
                  child: SvgPicture.asset('assets/icons/back.svg'),
                ),
              ),
              SizedBox(
                width: 15.sp,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
