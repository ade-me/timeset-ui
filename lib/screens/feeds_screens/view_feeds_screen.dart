import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:timeset/helpers/custom_pageview_scroll_physics.dart';
import 'package:timeset/models/content.dart';
import 'package:timeset/models/post.dart';

import '../../widgets/feeds_screen_widgets/single_feed.dart';

class ViewFeedsScreen extends StatefulWidget {
  const ViewFeedsScreen({super.key});

  @override
  State<ViewFeedsScreen> createState() => _ViewFeedsScreenState();
}

class _ViewFeedsScreenState extends State<ViewFeedsScreen> {
  final pageController = PreloadPageController(initialPage: 0);

  int currentPage = 0;

  static List<Post> items = [
    Post(
      title: "Pysavant",
      description: "Uwak Blessing",
      content: [
        Content(
          uri:
              "https://videos.pexels.com/video-files/5310962/5310962-sd_540_960_25fps.mp4",
          type: "video",
          effect: "none",
        )
      ],
      allowComment: true,
      people: ["123456776", "12345221"],
      product: ["123456776"],
      location: ["123456776", "12345221"],
    ),
    Post(
      title: "Pysavant",
      description: "Uwak Blessing",
      content: [
        Content(
          uri:
              "https://images.pexels.com/photos/1848565/pexels-photo-1848565.jpeg?auto=compress&cs=tinysrgb&w=600",
          type: "image",
          effect: "none",
        ),
        Content(
          uri:
              "https://www.getfishtank.com/-/media/images/fishtank/people/staff-updated-2023/nathan-1-edit.ashx",
          type: "image",
          effect: "none",
        ),
      ],
      allowComment: true,
      people: ["123456776", "12345221"],
      product: [
        "123456776",
      ],
      location: ["123456776", "12345221"],
    ),
    Post(
      title: "Pysavant",
      description: "Uwak Blessing",
      content: [
        Content(
          uri:
              "https://videos.pexels.com/video-files/4880454/4880454-hd_720_1366_25fps.mp4",
          type: "video",
          effect: "none",
        )
      ],
      allowComment: true,
      people: ["123456776", "12345221"],
      product: ["123456776"],
      location: ["123456776", "12345221"],
    ),
  ];

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
        itemCount: items.length,
        itemBuilder: (BuildContext context, int position) => SingleFeed(
          post: items[position],
          isInView: currentPage == position ? true : false,
        ),
        controller: pageController,
        onPageChanged: (int position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }
}
