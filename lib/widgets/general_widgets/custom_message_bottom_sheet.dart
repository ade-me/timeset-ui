import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class CustomMessageBottomSheet {
  static void showBottomSheet(context, title, description, icon) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(15.sp),
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
                  SizedBox(height: 30.sp),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    width: 80.w,
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
            Positioned(
              top: -30.sp,
              left: (MediaQuery.of(context).size.width / 2) - 45,
              child: Container(
                width: 60.sp,
                height: 60.sp,
                decoration: BoxDecoration(
                  color: HexColor("#9CBB30"),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(60),
                  ),
                  border: Border.all(
                    width: 6,
                    color: HexColor("#141414"),
                  ),
                ),
                child: Icon(
                  icon,
                  weight: 20,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
