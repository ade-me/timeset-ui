import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../general_widgets/general_app_padding.dart';

class MessagesTile extends StatelessWidget {
  const MessagesTile({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return GeneralAppPadding(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
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
                Visibility(
                  visible: index.isEven,
                  child: Container(
                    padding: EdgeInsets.all(4.sp),
                    decoration: BoxDecoration(
                      color: index == 0 ? Colors.yellow : Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 5.w),
            SizedBox(
              width: 60.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lewis Drew',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  SizedBox(
                    width: 55.w,
                    child: Text(
                      'Hello guys, we have discussed about Hello guys, we have discussed about',
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  '18:59',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                ),
                Visibility(
                  visible: index.isOdd,
                  replacement: const SizedBox.shrink(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(5.sp),
                    alignment: Alignment.center,
                    child: const Text('5'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
