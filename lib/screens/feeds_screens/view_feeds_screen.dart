import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:timeset/helpers/custom_pageview_scroll_physics.dart';

import '../../widgets/feeds_screen_widgets/single_feed.dart';

class ViewFeedsScreen extends StatefulWidget {
  const ViewFeedsScreen({super.key});

  @override
  State<ViewFeedsScreen> createState() => _ViewFeedsScreenState();
}

class _ViewFeedsScreenState extends State<ViewFeedsScreen> {
  final pageController = PreloadPageController(initialPage: 1);

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PreloadPageView.builder(
        physics: const CustomPageViewScrollPhysics(),
        scrollDirection: Axis.vertical,
        preloadPagesCount: 5,
        itemBuilder: (BuildContext context, int position) => const SingleFeed(),
        controller: pageController,
        onPageChanged: (int position) {
          // print('page changed. current: $position');
        },
      ),
    );
  }
}
