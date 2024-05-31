import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../../screens/chat_screens/call_screen.dart';
import 'call_type_bottom_sheet.dart';

enum CallType {
  audio,
  video,
}

void showCallDialog(BuildContext context, CallType callType) => showDialog(
      context: context,
      builder: (ctx) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: CallDialog(
          type: callType,
          cancelFunction: () {
            Navigator.pop(ctx);
            showCallTypeSheet(context);
          },
        ),
      ),
    );

class CallDialog extends StatelessWidget {
  const CallDialog({
    super.key,
    required this.type,
    required this.cancelFunction,
  });

  final CallType type;
  final Function()? cancelFunction;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var sizedBox = SizedBox(height: 2.h);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: 33.h),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: Column(
          children: [
            SizedBox(height: 3.h),
            Text(
              'Start Call?',
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
            ),
            sizedBox,
            SizedBox(
              width: 50.w,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      'Confirm your decision to ${type == CallType.audio ? 'voice' : 'video'} call',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.black54,
                  ),
                  children: [
                    TextSpan(
                      text: ' @lewisdrew',
                      style: textTheme.bodyMedium?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            sizedBox,
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  CallScreen.routeName,
                  arguments: type,
                );
              },
              child: Text(
                'Call',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: cancelFunction,
              child: Text(
                'Cancel',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
