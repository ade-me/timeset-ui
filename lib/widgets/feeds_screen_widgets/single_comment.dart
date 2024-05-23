import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/constants/app_colors.dart';

class SingleComment extends StatefulWidget {
  const SingleComment({super.key});

  @override
  State<SingleComment> createState() => _SingleCommentState();
}

class _SingleCommentState extends State<SingleComment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15.sp,
        left: 15.sp,
        right: 15.sp,
        bottom: 8.sp,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D",
                ),
                radius: 20,
              ),
              SizedBox(width: 3.w),
              const Text("Kriston Waston"),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            style: TextStyle(
              fontSize: 11.sp,
              color: HexColor("#8E8E8E"),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.favorite_outline_rounded,
                    color: Colors.white,
                    size: 17,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    "234",
                    style: TextStyle(
                      fontSize: 11.sp,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 6.w,
              ),
              Text(
                "3 days ago",
                style: TextStyle(
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(
                width: 6.w,
              ),
              Text(
                'Reply',
                style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }
}
