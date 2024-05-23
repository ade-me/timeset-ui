import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';

class Option extends StatefulWidget {
  const Option({
    super.key,
    this.icon = Icons.abc,
    this.text = "",
    this.hasCustomIcon = false,
    this.customIcon = "",
    this.onTap,
    this.isSelected = false,
  });
  final IconData icon;
  final String customIcon;
  final String text;
  final bool hasCustomIcon;
  final Function()? onTap;
  final bool isSelected;

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          widget.hasCustomIcon
              ? SvgPicture.asset(
                  "assets/icons/${widget.customIcon}.svg",
                  width: 18.sp,
                )
              : Icon(
                  widget.icon,
                  color: widget.isSelected ? AppColors.primary : Colors.white,
                  size: 20.sp,
                ),
          widget.text.isEmpty
              ? const SizedBox()
              : Column(
                  children: [
                    SizedBox(
                      height: widget.hasCustomIcon ? 5.sp : 3.sp,
                    ),
                    Text(
                      widget.text,
                      style: TextStyle(
                        fontSize: 10.sp,
                      ),
                    )
                  ],
                )
        ],
      ),
    );
  }
}
