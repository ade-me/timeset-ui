import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/widgets/general_widgets/custom_text_field.dart';

class SearchResultAppBar extends StatefulWidget {
  const SearchResultAppBar({
    super.key,
    required this.searchFocusNode,
    required this.searchTextController,
    required this.tabs,
    required this.tabController,
  });

  final TextEditingController searchTextController;
  final TabController? tabController;
  final FocusNode searchFocusNode;
  final List<String> tabs;

  @override
  State<SearchResultAppBar> createState() => _SearchResultAppBarState();
}

class _SearchResultAppBarState extends State<SearchResultAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 55.sp,
      title: CustomTextField(
        textInputType: TextInputType.text,
        textInputAction: TextInputAction.done,
        controller: widget.searchTextController,
        focusNode: widget.searchFocusNode,
        iconName: 'search_inactive',
        hintText: 'Search for anything',
        iconColor: HexColor("#9CBB30"),
      ),
      titleSpacing: 15.sp,
      bottom: TabBar(
        controller: widget.tabController,
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        dividerColor: HexColor("#2C2C2C"),
        indicatorColor: HexColor("#9CBB30"),
        labelColor: HexColor("#9CBB30"),
        unselectedLabelColor: HexColor('#AEAEAE'),
        labelPadding: const EdgeInsets.symmetric(horizontal: 0),
        indicatorSize: TabBarIndicatorSize.tab,
        overlayColor: const WidgetStatePropertyAll(Colors.white10),
        indicator: UnderlineTabIndicator(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(width: 3, color: HexColor("#9CBB30")),
        ),
        tabs: widget.tabs
            .map(
              (e) => Tab(
                child: Text(
                  e,
                  style: TextStyle(fontSize: 10.sp),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
