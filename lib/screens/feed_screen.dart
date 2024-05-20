import 'package:flutter/material.dart';

import '../widgets/homescreen_widgets/custom_home_app_bar.dart';

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
    Center(
      child: Text('Feeds'),
    ),
    Center(
      child: Text('Shop'),
    ),
    Center(
      child: Text('Discover'),
    ),
    Center(
      child: Text('Live'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHomeScreenAppBar(
          pageController: pageController,
          currentIndex: currentIndex,
        ),
        Expanded(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: _pages,
            onPageChanged: (index) => setState(() {
              currentIndex = index;
            }),
          ),
        ),
      ],
    );
  }
}
