import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'rating_widget.dart';

class ReviewListTile extends StatelessWidget {
  const ReviewListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF212121),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF2C2C2C),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
      margin: EdgeInsets.only(bottom: 2.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18.sp,
                backgroundImage: const NetworkImage(
                  'https://images.pexels.com/photos/992734/pexels-photo-992734.jpeg?auto=compress&cs=tinysrgb&w=600',
                ),
              ),
              SizedBox(width: 3.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Uwak Daniel',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '23/05/2024',
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const RatingWidget(),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et.',
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
