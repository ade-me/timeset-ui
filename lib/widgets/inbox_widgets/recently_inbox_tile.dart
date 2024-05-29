import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/bordered_user_profile_image.dart';

class RecentlyInboxTile extends StatelessWidget {
  const RecentlyInboxTile({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: index == 0 ? 5.w : 0, right: 7.w),
      child: Column(
        children: [
          BorderedUserProfileImage(
            imageUrl:
                'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
            h: 7.h,
            w: 15.w,
          ),
          SizedBox(height: 0.5.h),
          Text(
            'danny',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
