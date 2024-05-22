import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/general_app_padding.dart';

class AddshoppingItemsScreen extends StatefulWidget {
  const AddshoppingItemsScreen({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<AddshoppingItemsScreen> createState() => _AddshoppingItemsScreenState();
}

class _AddshoppingItemsScreenState extends State<AddshoppingItemsScreen> {
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GeneralAppPadding(
              verticalPadding: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarWithBackButton(
                    title: "Add shopping items",
                    hasCustomFunction: true,
                    function: () {
                      widget.pageController.jumpToPage(
                        1,
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
                    hintText: 'Search for an item',
                    iconColor: HexColor("#9CBB30"),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
