import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/screens/create_post_screens/create_post_screen.dart';

class CustomHomePlusPopUp {
  static void showHomePlusPopup(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 12.h),
                width: 100.w,
                child: Container(
                  width: 120.sp,
                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        splashColor: Colors.black12,
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.pushNamed(
                            context,
                            CreatePostScreen.routeName,
                          );
                        },
                        child: ListTile(
                          dense: true,
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -2),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          minVerticalPadding: 0,
                          title: Text(
                            "Post",
                            style: TextStyle(
                              color: HexColor("#000000"),
                              fontSize: 11.sp,
                            ),
                          ),
                          trailing: SvgPicture.asset("assets/icons/video.svg"),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -2),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 15),
                        minVerticalPadding: 0,
                        title: Text(
                          "Add timeline",
                          style: TextStyle(
                            color: HexColor("#000000"),
                            fontSize: 11.sp,
                          ),
                        ),
                        trailing: SvgPicture.asset("assets/icons/timeline.svg"),
                      ),
                      ListTile(
                        dense: true,
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -2),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 15),
                        minVerticalPadding: 0,
                        title: Text(
                          "Go Live",
                          style: TextStyle(
                            color: HexColor("#000000"),
                            fontSize: 11.sp,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.sensors_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                alignment: Alignment.center,
                height: 12.h,
                width: 100.w,
                child: IconButton(
                  style: ButtonStyle(
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.all(15),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      HexColor("#9CBB30"),
                    ),
                  ),
                  splashColor: Colors.white10,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    size: 15.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
