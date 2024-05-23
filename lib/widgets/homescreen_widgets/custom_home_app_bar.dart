import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../screens/shop_screens/cart_screen.dart';
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
    return Container(
      width: 100.w,
      color: const Color(0xFF202020),
      padding: EdgeInsets.symmetric(
        vertical: 2.h,
        horizontal: 5.w,
      ),
      child: Row(
        children: [
          Row(
            children: [
              CustomHomeAppBarChip(
                text: "Feeds",
                iconUrl: "assets/icons/feeds.svg",
                onTap: () => getToPage(0),
                isSelected: currentIndex == 0 ? true : false,
              ),
              CustomHomeAppBarChip(
                text: "Shop",
                iconUrl: "assets/icons/shop.svg",
                onTap: () => getToPage(1),
                isSelected: currentIndex == 1 ? true : false,
              ),
              CustomHomeAppBarChip(
                text: "Discover",
                iconUrl: "assets/icons/discover.svg",
                onTap: () => getToPage(2),
                isSelected: currentIndex == 2 ? true : false,
              ),
            ],
          ),
          const Spacer(),
          currentIndex == 1
              ? GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    CartScreen.routeName,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                      Text(
                        "CART",
                        style: TextStyle(fontSize: 9.sp),
                      ),
                    ],
                  ),
                )
              : GestureDetector(
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
                ),
        ],
      ),
    );
  }

  void getToPage(int index) => pageController.jumpToPage(index);
}
