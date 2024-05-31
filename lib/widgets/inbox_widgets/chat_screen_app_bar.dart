import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../general_widgets/general_app_padding.dart';
import 'call_type_bottom_sheet.dart';

class ChatScreenAppBar extends StatelessWidget {
  const ChatScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var sizedBox = SizedBox(width: 3.w);

    return Column(
      children: [
        GeneralAppPadding(
          child: Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
              ),
              sizedBox,
              CircleAvatar(
                radius: 17.sp,
                backgroundColor: AppColors.primary,
                backgroundImage: const NetworkImage(
                  'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=600',
                ),
              ),
              sizedBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lewis Drew',
                    style: textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'was last active 7:20PM',
                    style: textTheme.bodySmall?.copyWith(color: Colors.white60),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showCallTypeSheet(context);
                },
                icon: const Icon(
                  Icons.call_rounded,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h),
        const Divider(
          thickness: 0.2,
          height: 0,
        ),
      ],
    );
  }
}
