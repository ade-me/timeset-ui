import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/homescreen_widgets/custom_home_appbar_chip.dart';

class CustomHomeScreenAppBar extends StatelessWidget {
  const CustomHomeScreenAppBar({
    super.key,
    required this.pageController,
    required this.currentIndex,
  });

  final PageController pageController;
  final int currentIndex;

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
              CustomHomeAppBarChip(
                text: "Feeds",
                iconUrl: "assets/icons/feeds.svg",
                onTap: () => getToPage(0),
                isSelected: currentIndex == 0 ? true : false,
              ),
              SizedBox(
                width: 7.sp,
              ),
              CustomHomeAppBarChip(
                text: "Shop",
                iconUrl: "assets/icons/shop.svg",
                onTap: () => getToPage(1),
                isSelected: currentIndex == 1 ? true : false,
              ),
              SizedBox(
                width: 7.sp,
              ),
              CustomHomeAppBarChip(
                text: "Discover",
                iconUrl: "assets/icons/discover.svg",
                onTap: () => getToPage(2),
                isSelected: currentIndex == 2 ? true : false,
              ),
            ],
          ),
          GestureDetector(
            onTap: () => getToPage(3),
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
          )
        ],
      ),
    );
  }

  void getToPage(int index) => pageController.jumpToPage(index);
}
