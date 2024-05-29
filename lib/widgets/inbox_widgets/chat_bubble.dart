import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.isMe,
  });

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: isMe ? 20.w : 5.w,
          right: isMe ? 5.w : 20.w,
          bottom: 4.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 2.w,
          vertical: 1.h,
        ),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.only(
            topLeft: isMe ? const Radius.circular(20) : Radius.zero,
            topRight: !isMe ? const Radius.circular(20) : Radius.zero,
            bottomLeft: const Radius.circular(20),
            bottomRight: const Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Text(
              'Hello, I have discussed about post-corona vacation plan and our decision is to go to Bali. We will have a very big party after this corona ends! These are some images about our destination',
              style: TextStyle(
                color: isMe ? const Color(0xFF141414) : null,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '16:04',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isMe ? const Color(0xFF141414) : Colors.white54,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
