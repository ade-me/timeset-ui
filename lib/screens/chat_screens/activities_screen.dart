import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/general_app_padding.dart';

class ActivitiesScreen extends StatelessWidget {
  static const routeName = '/ActivitiesScreen';

  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 1.h);
    return Scaffold(
      body: SafeArea(
        child: GeneralAppPadding(
          child: Column(
            children: [
              const AppBarWithBackButton(
                title: 'Activities',
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBox,
                    const Text('Today'),
                    sizedBox,
                    const ActivityTile(
                      type: ActivityType.like,
                    ),
                    const ActivityTile(
                      type: ActivityType.follow,
                    ),
                    sizedBox,
                    const Text('Yesterday'),
                    sizedBox,
                    const ActivityTile(
                      type: ActivityType.follow,
                    ),
                    const ActivityTile(
                      type: ActivityType.like,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ActivityType {
  follow,
  like,
}

class ActivityTile extends StatelessWidget {
  const ActivityTile({
    super.key,
    required this.type,
  });

  final ActivityType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 20.sp,
                backgroundColor: AppColors.primary,
                backgroundImage: const NetworkImage(
                  'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=600',
                ),
              ),
              Positioned(
                left: 18.sp,
                child: Visibility(
                  visible: type == ActivityType.like,
                  child: Container(
                    padding: EdgeInsets.all(4.sp),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 3,
                      ),
                    ),
                    child: Text(
                      '+254',
                      style: TextStyle(
                        fontSize: 5.sp,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 3.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ariana Cooper',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                type == ActivityType.follow
                    ? 'started following you'
                    : 'liked your video',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.white70),
              ),
            ],
          ),
          const Spacer(),
          type == ActivityType.follow
              ? SizedBox(
                  height: 4.h,
                  width: 27.w,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onPressed: null,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 12.sp,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            'Follow Back',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.black,
                                      fontSize: 8.sp,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://images.pexels.com/photos/906531/pexels-photo-906531.jpeg?auto=compress&cs=tinysrgb&w=600',
                    height: 8.h,
                    width: 18.w,
                    fit: BoxFit.cover,
                  ),
                ),
        ],
      ),
    );
  }
}
