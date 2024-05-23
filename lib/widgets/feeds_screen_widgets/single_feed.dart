import 'package:flutter/material.dart';

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
      child: const Stack(
        children: [
          Positioned(
            bottom: 5,
            child: FeedOptions(),
          ),
        ],
      ),
    );
  }
}
