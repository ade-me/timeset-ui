import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/state_management/user_provider.dart';
import 'package:timeset/widgets/auth_widgets/auth_button.dart';
import 'package:timeset/widgets/general_widgets/app_bar_with_back_button.dart';
import 'package:timeset/widgets/general_widgets/custom_text_field.dart';
import 'package:timeset/widgets/general_widgets/general_app_padding.dart';

class EditFieldPage extends StatefulWidget {
  const EditFieldPage({
    super.key,
    required this.pageController,
    required this.fieldToUpdate,
    required this.editTitle,
  });
  final PageController pageController;
  final String fieldToUpdate;
  final String editTitle;

  @override
  State<EditFieldPage> createState() => _EditFieldPageState();
}

class _EditFieldPageState extends State<EditFieldPage> {
  final editTextController = TextEditingController();

  final editFocusNode = FocusNode();

  @override
  void initState() {
    final userPvr = Provider.of<UserProvider>(context, listen: false).user;
    super.initState();
    final fieldToUpdate = widget.fieldToUpdate;

    final fieldMap = {
      'username': userPvr.username,
      'fullName': userPvr.fullName,
      'about': userPvr.about,
    };
    editTextController.text = fieldMap[fieldToUpdate]!;
  }

  @override
  void dispose() {
    super.dispose();

    editTextController.dispose();

    editFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (willPop) {
        widget.pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutCirc,
        );
      },
      child: SafeArea(
        child: Column(
          children: [
            GeneralAppPadding(
              verticalPadding: 3,
              child: AppBarWithBackButton(
                title: "Edit ${widget.editTitle}",
                hasCustomFunction: true,
                function: () {
                  widget.pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOutCirc,
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
                child: CustomTextField(
                  minWidth: 7,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: editTextController,
                  focusNode: editFocusNode,
                  hintText: 'Enter a ${widget.editTitle}',
                ),
              ),
            ),
            GeneralAppPadding(
              verticalPadding: 6.w,
              child: AuthButton(
                text: "Save",
                function: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
