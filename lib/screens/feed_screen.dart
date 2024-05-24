import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/screens/feeds_screens/view_feeds_screen.dart';

import '../widgets/homescreen_widgets/custom_home_app_bar.dart';
import 'shop_screens/shop_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final pageController = PageController();
  int currentIndex = 0;

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();
  }

  final List<Widget> _pages = const [
    ViewFeedsScreen(),
    ShopScreen(),
    Center(
      child: Text('Discover'),
    ),
    Center(
      child: Text('Live'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: _pages,
          onPageChanged: (index) => setState(() {
            currentIndex = index;
          }),
        ),
        Positioned(
          top: 2.5.h,
          child: CustomHomeScreenAppBar(
            pageController: pageController,
            currentIndex: currentIndex,
          ),
        ),
      ],
    );
  }
}
