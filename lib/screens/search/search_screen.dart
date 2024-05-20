import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/widgets/general_widgets/custom_text_field.dart';
import 'package:timeset/widgets/general_widgets/general_app_padding.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
    return Container(
      color: HexColor("#0e0e0e"),
      child: GeneralAppPadding(
        verticalPadding: 3.h,
        child: Column(
          children: [
            CustomTextField(
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.done,
              controller: searchTextController,
              focusNode: searchFocusNode,
              iconName: 'search_inactive',
              hintText: 'Search for anything',
              iconColor: HexColor("#9CBB30"),
            ),
            SizedBox(
              height: 2.5.h,
            ),
            SingleChildScrollView(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Recent"),
                    GestureDetector(
                      child: Text(
                        "Clear all",
                        style: TextStyle(
                          color: HexColor("#9CBB30"),
                          fontSize: 11.sp,
                        ),
                      ),
                      onTap: () {},
                    )
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
