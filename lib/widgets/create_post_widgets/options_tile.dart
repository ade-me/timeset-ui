import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';

class OptionsTile extends StatefulWidget {
  const OptionsTile({
    super.key,
    required this.title,
    this.icon = "user",
    required this.onTap,
    this.hasCustomIcon = false,
    this.customIcon = Icons.abc,
    this.trailingText = "",
    this.isDisabled = false,
  });

  final String title;
  final String icon;
  final Function()? onTap;
  final bool hasCustomIcon;
  final IconData customIcon;
  final String trailingText;
  final bool isDisabled;

  @override
  State<OptionsTile> createState() => _OptionsTileState();
}

class _OptionsTileState extends State<OptionsTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white10,
      onTap: widget.isDisabled ? null : widget.onTap,
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(
          vertical: -4,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 7.sp),
        title: Row(
          children: [
            widget.hasCustomIcon
                ? Icon(
                    widget.customIcon,
                    color: AppColors.primary,
                    size: 28,
                  )
                : SvgPicture.asset("assets/icons/${widget.icon}.svg"),
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: widget.trailingText.isNotEmpty,
              child: SizedBox(
                width: widget.isDisabled ? 25.w : 15.w,
                child: Text(
                  textAlign: TextAlign.right,
                  widget.trailingText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.5.sp,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !widget.isDisabled,
              child: SizedBox(
                width: widget.trailingText.isNotEmpty ? 10 : 0,
              ),
            ),
            Visibility(
              visible: !widget.isDisabled,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
