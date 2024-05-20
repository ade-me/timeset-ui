import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/homescreen_widgets/custom_home_appbar_chip.dart';

class CustomHomeScreenAppBar extends StatefulWidget {
  const CustomHomeScreenAppBar({super.key});

  @override
  State<CustomHomeScreenAppBar> createState() => _CustomHomeScreenAppBarState();
}

class _CustomHomeScreenAppBarState extends State<CustomHomeScreenAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.sp,
        horizontal: 13.sp,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CustomHomeAppBarChip(
                text: "Feeds",
                iconUrl: "assets/icons/feeds.svg",
              ),
              SizedBox(
                width: 7.sp,
              ),
              const CustomHomeAppBarChip(
                text: "Shop",
                iconUrl: "assets/icons/shop.svg",
              ),
              SizedBox(
                width: 7.sp,
              ),
              const CustomHomeAppBarChip(
                text: "Discover",
                iconUrl: "assets/icons/discover.svg",
              ),
            ],
          ),
          GestureDetector(
            child: Container(
              child: Column(
                children: [
                  Icon(
                    Icons.sensors_rounded,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                  Text(
                    "LIVE",
                    style: TextStyle(fontSize: 9.sp),
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
