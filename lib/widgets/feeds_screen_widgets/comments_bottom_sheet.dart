import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/custom_text_field.dart';
import 'comments.dart';

class CommentsBottomSheet {
  static void showBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CommentBottomSheet(),
    );
  }
}

class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({
    super.key,
  });

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final textController = TextEditingController();
  final focusNode = FocusNode();

  bool isFocused = false;

  void checkFocus() => setState(
        () => focusNode.hasFocus ? isFocused = true : isFocused = false,
      );

  @override
  void dispose() {
    super.dispose();

    textController.dispose();

    focusNode.dispose();
  }

  @override
  void initState() {
    super.initState();

    focusNode.addListener(checkFocus);
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Container(
        width: 100.w,
        height: !isFocused ? 70.h : 95.h,
        padding: EdgeInsets.only(
          top: 10.sp,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          color: HexColor("#212121"),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 20.w,
              height: 3.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: HexColor("#4E4E4E"),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            const Text(
              "3.5k Comments",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Divider(
              height: 1,
              color: HexColor("#2C2C2C"),
            ),
            const Comments(),
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: CommentTextField(
                focusNode: focusNode,
                controller: textController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
