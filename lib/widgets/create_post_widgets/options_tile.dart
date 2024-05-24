import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class OptionsTile extends StatefulWidget {
  const OptionsTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String icon;
  final Function()? onTap;

  @override
  State<OptionsTile> createState() => _OptionsTileState();
}

class _OptionsTileState extends State<OptionsTile> {
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
            SvgPicture.asset("assets/icons/${widget.icon}.svg"),
            SizedBox(
              width: 8.sp,
            ),
            SizedBox(
              width: 60.w,
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
          size: 13.sp,
        ),
      ),
    );
  }
}
