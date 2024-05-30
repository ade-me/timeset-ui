import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';

class SendTextField extends StatefulWidget {
  const SendTextField({
    super.key,
  });

  @override
  State<SendTextField> createState() => _SendTextFieldState();
}

class _SendTextFieldState extends State<SendTextField> {
  final _messageTextController = TextEditingController();

  bool hasInput = false;

  void checkInput() => setState(
        () => _messageTextController.text.isEmpty
            ? hasInput = false
            : hasInput = true,
      );

  @override
  void initState() {
    _messageTextController.addListener(checkInput);

    super.initState();
  }

  @override
  void dispose() {
    _messageTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Row(
      children: [
        Flexible(
          child: TextField(
            controller: _messageTextController,
            maxLines: 5,
            style: textTheme.bodySmall,
            minLines: 1,
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
        InkWell(
          onTap: null,
          child: Container(
            decoration: BoxDecoration(
              color: hasInput ? AppColors.primary : Colors.white30,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(5.sp),
            alignment: Alignment.center,
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
