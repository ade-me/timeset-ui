import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../widgets/searchscreen_widgets/searchresult_appbar.dart';

class SearchResultScreen extends StatefulWidget {
  static const routeName = '/SearchResultScreen';
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen>
    with TickerProviderStateMixin {
  final searchTextController = TextEditingController();
  TabController? tabController;

  final searchFocusNode = FocusNode();

  List<String> tabs = ["Top", "Users", "Videos", "Shop", "Sound"];

  void setSearchValue(val) {
    searchTextController.text = val;
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();

    searchTextController.dispose();
    tabController?.dispose();

    searchFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    setSearchValue(arguments['searchValue']);

    return Scaffold(
      backgroundColor: HexColor("#111111"),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: SearchResultAppBar(
          searchFocusNode: searchFocusNode,
          searchTextController: searchTextController,
          tabs: tabs,
          tabController: tabController,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          Center(
            child: Text("Top"),
          ),
          Center(
            child: Text("Users"),
          ),
          Center(
            child: Text("Videos"),
          ),
          Center(
            child: Text("Shop"),
          ),
          Center(
            child: Text("Sound"),
          ),
        ],
      ),
    );
  }
}
