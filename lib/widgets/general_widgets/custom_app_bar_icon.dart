import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class CustomAppBarIcon extends StatelessWidget {
  const CustomAppBarIcon({
    super.key,
    required this.function,
    required this.icon,
  });

  final Function()? function;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: function,
      splashColor: Colors.white10,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: HexColor("#2C2C2C"), width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.all(9.sp),
        alignment: Alignment.center,
        child: SvgPicture.asset('assets/icons/$icon.svg'),
      ),
    );
  }
}
