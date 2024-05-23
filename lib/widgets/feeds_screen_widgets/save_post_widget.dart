import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/constants/app_colors.dart';

class SavePostWidget extends StatefulWidget {
  const SavePostWidget({super.key});

  @override
  State<SavePostWidget> createState() => _SavePostWidgetState();
}

class _SavePostWidgetState extends State<SavePostWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(15.sp),
          child: Row(
            children: [
              Icon(
                Icons.bookmark_outline_rounded,
                color: AppColors.primary,
                size: 24.sp,
              ),
              SizedBox(
                width: 3.w,
              ),
              const Text(
                "Save Post",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        Divider(
          color: HexColor("#2C2C2C"),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Add items from post to bucket list",
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
