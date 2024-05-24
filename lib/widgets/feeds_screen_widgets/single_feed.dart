import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/feeds_screen_widgets/feed_options.dart';

class SingleFeed extends StatefulWidget {
  const SingleFeed({super.key});

  @override
  State<SingleFeed> createState() => _SingleFeedState();
}

class _SingleFeedState extends State<SingleFeed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border.symmetric(
        horizontal: BorderSide(
          color: Colors.white10,
          width: 0.5,
        ),
      )),
      child: Stack(
        children: [
          Image.network(
            'https://images.pexels.com/photos/13914818/pexels-photo-13914818.jpeg?auto=compress&cs=tinysrgb&w=600',
            height: 100.h,
            width: 100.w,
            fit: BoxFit.cover,
          ),
          const Positioned(
            bottom: 5,
            child: FeedOptions(),
          ),
        ],
      ),
    );
  }
}
