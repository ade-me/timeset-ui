import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/widgets/general_widgets/general_app_padding.dart';

import '../../constants/app_colors.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/ChatScreen';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageTextController = TextEditingController();

  @override
  void dispose() {
    _messageTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ChatScreenAppBar(),
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                reverse: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (ctx, index) {
                  bool isMe = index.isOdd;
                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
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
                        color:
                            isMe ? AppColors.primary : const Color(0xFF2C2C2C),
                        borderRadius: BorderRadius.only(
                          topLeft:
                              isMe ? const Radius.circular(20) : Radius.zero,
                          topRight:
                              !isMe ? const Radius.circular(20) : Radius.zero,
                          bottomLeft: const Radius.circular(20),
                          bottomRight: const Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Hello, I have discussed about post-corona vacation plan and our decision is to go to Bali. We will have a very big party after this corona ends! These are some images about our destination',
                        style: TextStyle(
                          color: isMe ? Colors.white : null,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(
              thickness: 0.2,
              height: 0,
            ),
            SizedBox(height: 1.h),
            SendTextField(
              messageTextController: _messageTextController,
            ),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }
}

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
        const IconButton(
          onPressed: null,
          icon: Icon(
            Icons.attach_file_rounded,
            color: Colors.white60,
          ),
        ),
        SizedBox(width: 2.w),
        InkWell(
          onTap: null,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(5.sp),
            child: Icon(
              Icons.mic_rounded,
              color: theme.scaffoldBackgroundColor,
            ),
          ),
        ),
        SizedBox(width: 2.w),
      ],
    );
  }
}

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
                onPressed: () {},
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
