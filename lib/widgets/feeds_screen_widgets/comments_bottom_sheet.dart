import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class CommentsBottomSheet {
  static void showBottomSheet(context, child) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          width: 100.w,
          height: 60.h + MediaQuery.of(context).viewInsets.bottom,
          padding: EdgeInsets.only(top: 10.sp),
          decoration: BoxDecoration(
            color: HexColor("#212121"),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 20.w,
                height: 3.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: HexColor("#4E4E4E"),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              const Text(
                "3.5k Comments",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                width: 100.w,
                height: 1,
                color: HexColor("#2C2C2C"),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
