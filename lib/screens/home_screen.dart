import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../screens/feed_screen.dart';
import '../screens/search/search_screen.dart';
import '../../widgets/homescreen_widgets/custom_bottom_nav.dart';
import '../services/api_client.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () => ApiClient.setContext(context));
  }

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.green,
    ));
    List<Widget> pages = [
      const FeedScreen(),
      const SearchScreen(),
    ];

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) => setState(() {
                currentIndex = index;
              }),
              children: pages,
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 12.h,
          child: CustomBottomNav(
            pageController: pageController,
            currentIndex: currentIndex,
          ),
        ),
      ),
    );
  }
}
