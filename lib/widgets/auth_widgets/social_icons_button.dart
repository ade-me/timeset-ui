import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({
    super.key,
    this.onTap,
    required this.icon,
  });

  final Function()? onTap;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white10,
      child: Container(
        padding: EdgeInsets.all(12.sp),
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF2C2C2C),
            width: 1,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset('assets/icons/$icon.svg'),
      ),
    );
  }
}
