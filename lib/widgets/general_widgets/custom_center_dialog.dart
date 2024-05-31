import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class CustomCenterDialog {
  static void showCustomDialog(
    context,
    String actionText,
    Color actionColor,
    String heading,
    String message,
    Function() function,
  ) {
    showDialog(
      context: context,
      builder: (_) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            title: Text(
              heading,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 40.w,
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: HexColor(
                        "#8E8E8E",
                      ),
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              Column(
                children: [
                  InkWell(
                    splashColor: Colors.black12,
                    onTap: () {
                      Navigator.pop(context);
                      function();
                    },
                    child: Container(
                      width: 100.w,
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        actionText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: actionColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.black12,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 100.w,
                      padding: const EdgeInsets.all(12),
                      child: const Text(
                        "Cancel",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
