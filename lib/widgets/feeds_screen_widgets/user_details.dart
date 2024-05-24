import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({
    super.key,
    required this.userInfo,
    required this.userName,
    required this.userImage,
    required this.isFollowing,
    this.onFollow,
    this.onTap,
  });
  final String userName;
  final String userInfo;
  final String userImage;
  final bool isFollowing;
  final Function()? onFollow;
  final Function()? onTap;

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              widget.userImage,
            ),
            radius: 15.sp,
          ),
          SizedBox(
            width: 3.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.userName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 0.3.h,
              ),
              Text(
                widget.userInfo,
                style: TextStyle(
                  fontSize: 9.sp,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 4.w,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7.sp, vertical: 5.sp),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20.sp),
            ),
            child: GestureDetector(
              onTap: widget.onFollow,
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    size: 12.sp,
                  ),
                  SizedBox(
                    width: 1.5.w,
                  ),
                  Text(
                    "Follow",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
