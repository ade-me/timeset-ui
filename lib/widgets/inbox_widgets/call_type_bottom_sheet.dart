import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'call_dialog.dart';

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
}
