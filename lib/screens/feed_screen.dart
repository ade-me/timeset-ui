import 'package:flutter/material.dart';

import '../widgets/homescreen_widgets/custom_home_app_bar.dart';
import 'feeds_screens/view_feeds_screen.dart';
import 'shop_screens/shop_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int currentIndex = 0;

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
          controller: widget.pageController,
          children: _pages,
          onPageChanged: (index) => setState(() {
            currentIndex = index;
          }),
        ),
        Positioned(
          top: MediaQuery.of(context).viewPadding.top,
          child: CustomHomeScreenAppBar(
            pageController: widget.pageController,
            currentIndex: currentIndex,
          ),
        ),
      ],
    );
  }
}
