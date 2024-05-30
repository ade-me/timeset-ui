import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/create_post_widgets/caption_textfield.dart';
import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/general_app_padding.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({
    super.key,
    required this.pageController,
  });
  final PageController pageController;

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  final subjectTextController = TextEditingController();
  final messageTextController = TextEditingController();

  final subjectFocusNode = FocusNode();
  final messageFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    subjectTextController.dispose();
    messageTextController.dispose();

    subjectFocusNode.dispose();
    messageFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (willPop) {
        setState(() {
          subjectTextController.text = "";
          messageTextController.text = "";
        });
        widget.pageController.jumpTo(0);
      },
      child: SafeArea(
        child: Column(
          children: [
            GeneralAppPadding(
              verticalPadding: 3,
              child: AppBarWithBackButton(
                title: "Report a problem",
                hasCustomFunction: true,
                function: () {
                  setState(() {
                    subjectTextController.text = "";
                    messageTextController.text = "";
                  });
                  widget.pageController.jumpTo(
                    0,
                  );
                },
              ),
            ),
            SizedBox(
              height: 1.w,
            ),
            Expanded(
              child: GeneralAppPadding(
                verticalPadding: 1.w,
                child: Column(
                  children: [
                    CustomTextField(
                      minWidth: 5,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: subjectTextController,
                      focusNode: subjectFocusNode,
                      hintText: 'Subject',
                      borderRadius: 20,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CaptionTextfield(
                      controller: messageTextController,
                      focusNode: messageFocusNode,
                      hintText: 'Message',
                    ),
                  ],
                ),
              ),
            ),
            GeneralAppPadding(
              verticalPadding: 6.w,
              child: AuthButton(
                text: "Submit",
                function: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
