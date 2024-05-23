import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        RatingIcon(),
        RatingIcon(),
        RatingIcon(),
        RatingIcon(),
        RatingIcon(),
      ],
    );
  }
}

class RatingIcon extends StatelessWidget {
  const RatingIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2.sp),
      child: const Icon(
        Icons.star_rate_rounded,
        color: Colors.amber,
        size: 18,
      ),
    );
  }
}
