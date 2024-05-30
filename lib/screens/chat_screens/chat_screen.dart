import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/inbox_widgets/chat_bubble.dart';
import '../../widgets/inbox_widgets/chat_screen_app_bar.dart';
import '../../widgets/inbox_widgets/send_text_field.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/ChatScreen';

  const ChatScreen({super.key});

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
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (ctx, index) {
                  bool isMe = index.isOdd;
                  return ChatBubble(isMe: isMe);
                },
              ),
            ),
            const Divider(
              thickness: 0.2,
              height: 0,
            ),
            SizedBox(height: 1.h),
            const SendTextField(),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }
}
