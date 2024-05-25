import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/create_post_widgets/caption_textfield.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/general_app_padding.dart';
import '../../widgets/create_post_widgets/options_tile.dart';
import '../../widgets/create_post_widgets/tag_chip.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({
    super.key,
    required this.pageController,
    this.onPostClicked,
    this.location = "Add Location",
    required this.captionFieldController,
  });
  final PageController pageController;
  final Function()? onPostClicked;
  final String location;
  final TextEditingController captionFieldController;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final captionFieldFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    captionFieldFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GeneralAppPadding(
                      verticalPadding: 10,
                      child: Column(
                        children: [
                          AppBarWithBackButton(
                            title: "Post",
                            hasCustomFunction: true,
                            function: () {
                              widget.pageController.previousPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOutCirc,
                              );
                            },
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CaptionTextfield(
                                  controller: widget.captionFieldController,
                                  focusNode: captionFieldFocusNode,
                                  hintText: "Enter a caption",
                                ),
                              ),
                              // SizedBox(
                              //   width: 3.w,
                              // ),
                              // const CoverSelect(),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              TagChip(
                                onTap: () {},
                                text: "Hashtag",
                                icon: Icons.tag,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              TagChip(
                                onTap: () {},
                                text: "Mention",
                                icon: Icons.alternate_email_rounded,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      color: HexColor("#2C2C2C"),
                      height: 1,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    OptionsTile(
                      title: "Tag People",
                      icon: "user",
                      onTap: () {
                        widget.pageController.jumpToPage(
                          2,
                        );
                      },
                    ),
                    OptionsTile(
                      title: widget.location,
                      icon: "location",
                      onTap: () {
                        widget.pageController.jumpToPage(
                          3,
                        );
                      },
                    ),
                    OptionsTile(
                      title: "Allow Comments",
                      icon: "comment",
                      onTap: () {},
                    ),
                    OptionsTile(
                      title: "Add shopping items",
                      icon: "shop2",
                      onTap: () {
                        widget.pageController.jumpToPage(4);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.w),
              child: AuthButton(
                text: 'Post',
                hasIcon: true,
                icon: "send",
                function: () {
                  widget.onPostClicked!();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
