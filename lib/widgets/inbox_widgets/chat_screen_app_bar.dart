import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../general_widgets/general_app_padding.dart';
import 'call_screen.dart';

class ChatScreenAppBar extends StatelessWidget {
  const ChatScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var sizedBox = SizedBox(width: 3.w);

    return Column(
      children: [
        GeneralAppPadding(
          child: Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
              ),
              sizedBox,
              CircleAvatar(
                radius: 17.sp,
                backgroundColor: AppColors.primary,
                backgroundImage: const NetworkImage(
                  'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=600',
                ),
              ),
              sizedBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lewis Drew',
                    style: textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'was last active 7:20PM',
                    style: textTheme.bodySmall?.copyWith(color: Colors.white60),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showCallTypeSheet(context);
                },
                icon: const Icon(
                  Icons.call_rounded,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h),
        const Divider(
          thickness: 0.2,
          height: 0,
        ),
      ],
    );
  }
}

void showCallTypeSheet(BuildContext context) => showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: const CallTypeBottomSheet(),
      ),
    );

class CallTypeBottomSheet extends StatelessWidget {
  const CallTypeBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: 100.w,
      decoration: const BoxDecoration(
        color: Color(0xFF212121),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Text('Select an action'),
            ],
          ),
          SizedBox(height: 3.h),
          actionButton(
            context,
            position: 0,
            type: CallType.audio,
          ),
          const Divider(height: 0, color: Colors.white10),
          actionButton(
            context,
            position: 1,
            type: CallType.video,
          ),
        ],
      ),
    );
  }

  InkWell actionButton(
    BuildContext context, {
    required int position,
    required CallType type,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        showCallDialog(context, type);
      },
      child: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
        decoration: BoxDecoration(
          color: const Color(0xFF141414),
          borderRadius: BorderRadius.vertical(
            top: position == 0 ? const Radius.circular(15) : Radius.zero,
            bottom: position != 0 ? const Radius.circular(15) : Radius.zero,
          ),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          type == CallType.audio ? 'Voice Call' : 'Video Call',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
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
}

enum CallType {
  audio,
  video,
}

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
