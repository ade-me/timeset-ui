import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/widgets/feeds_screen_widgets/single_comment.dart';
import 'package:timeset/widgets/general_widgets/custom_text_field.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final textController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    textController.dispose();

    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.h,
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return const SingleComment();
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.sp),
          child: CommentTextField(
            focusNode: focusNode,
            controller: textController,
          ),
        )
      ],
    );
  }
}
