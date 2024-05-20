import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/screens/search/search_result_screen.dart';

import '../../widgets/searchscreen_widgets/search_history_tile.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/general_app_padding.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchTextController = TextEditingController();

  final searchFocusNode = FocusNode();

  List<String> searchHistory = [
    'James bond',
    'Karren Jo',
    'Southamption',
    'James'
  ];

  String searchValue = "";

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
              textInputAction: TextInputAction.go,
              controller: searchTextController,
              focusNode: searchFocusNode,
              iconName: 'search_inactive',
              hintText: 'Search for anything',
              iconColor: HexColor("#9CBB30"),
              onSubmitted: (value) {
                setState(() {
                  searchValue = value;
                });
              },
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
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Column(
                  children: searchHistory
                      .map(
                        (e) => SearchHistoryTile(
                          text: e,
                          onRemove: () {
                            searchHistory.remove(e);
                            setState(() {});
                          },
                          onTap: () {
                            setState(() {
                              searchValue = e;
                            });
                            Navigator.pushNamed(
                              context,
                              SearchResultScreen.routeName,
                              arguments: {
                                'searchValue': searchValue,
                              },
                            );
                          },
                        ),
                      )
                      .toList(),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
