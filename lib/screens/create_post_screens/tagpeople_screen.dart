import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/general_app_padding.dart';

class TagpeopleScreen extends StatefulWidget {
  const TagpeopleScreen({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<TagpeopleScreen> createState() => _TagpeopleScreenState();
}

class _TagpeopleScreenState extends State<TagpeopleScreen> {
  final searchTextController = TextEditingController();

  final searchFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    searchTextController.dispose();

    searchFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (willPop) {
        widget.pageController.jumpToPage(2);
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              GeneralAppPadding(
                verticalPadding: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarWithBackButton(
                      title: "Tag people",
                      hasCustomFunction: true,
                      function: () {
                        widget.pageController.jumpToPage(
                          2,
                        );
                      },
                    ),
                    SizedBox(
                      height: 1.w,
                    ),
                    CustomTextField(
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      controller: searchTextController,
                      focusNode: searchFocusNode,
                      iconName: 'search_inactive',
                      hintText: 'Search for user',
                      iconColor: HexColor("#9CBB30"),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    const Text(
                      "3/20 Selected",
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    // const UserSelect(
                    //   userName: "Ariana Grande",
                    //   userImage: "",
                    //   userInfo: "arianagrande | 27.3M followers",
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
