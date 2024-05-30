import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    super.key,
    required this.title,
    this.icon = "user",
    required this.onTap,
    required this.customIcon,
    this.trailingText = "",
    this.switchValue = false,
    required this.onChange,
  });

  final String title;
  final String icon;
  final Function()? onTap;
  final IconData customIcon;
  final String trailingText;
  final bool switchValue;
  final Function(bool) onChange;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white10,
      onTap: widget.onTap,
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(
          vertical: -4,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 7.sp),
        title: Row(
          children: [
            Icon(
              widget.customIcon,
              color: AppColors.primary,
              size: 28,
            ),
            SizedBox(
              width: 8.sp,
            ),
            SizedBox(
              width: widget.trailingText.isNotEmpty ? 50.w : 60.w,
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.5.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        trailing: Switch(
          activeTrackColor: AppColors.primary,
          inactiveTrackColor: HexColor("#39393D"),
          inactiveThumbColor: Colors.white,
          value: widget.switchValue,
          onChanged: widget.onChange,
        ),
      ),
    );
  }
}
