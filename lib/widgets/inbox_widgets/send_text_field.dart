import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';

class SendTextField extends StatelessWidget {
  const SendTextField({
    super.key,
    required TextEditingController messageTextController,
  }) : _messageTextController = messageTextController;

  final TextEditingController _messageTextController;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Row(
      children: [
        Flexible(
          child: TextField(
            controller: _messageTextController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'Write a message...',
              hintStyle: textTheme.bodySmall?.copyWith(
                color: Colors.white60,
              ),
            ),
          ),
        ),
        // const IconButton(
        //   onPressed: null,
        //   icon: Icon(
        //     Icons.attach_file_rounded,
        //     color: Colors.white60,
        //   ),
        // ),
        // SizedBox(width: 2.w),
        InkWell(
          onTap: null,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(5.sp),
            child: Icon(
              Icons.send_rounded,
              color: theme.scaffoldBackgroundColor,
            ),
          ),
        ),
        SizedBox(width: 2.w),
      ],
    );
  }
}
