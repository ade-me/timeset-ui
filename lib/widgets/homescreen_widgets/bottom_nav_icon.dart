import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class BottomNavIcon extends StatelessWidget {
  const BottomNavIcon({
    super.key,
    required this.activeIconUrl,
    required this.inActiveIconUrl,
    required this.index,
    required this.pageController,
    required this.currentIndex,
    this.extraFunction,
  });

  final String activeIconUrl;
  final String inActiveIconUrl;
  final int index;
  final int currentIndex;
  final PageController pageController;
  final Function()? extraFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => changePage(index, context),
      child: SvgPicture.asset(
        currentIndex == index ? activeIconUrl : inActiveIconUrl,
        height: 3.1.h,
        width: 3.1.h,
      ),
    );
  }

  void changePage(int index, context) {
    pageController.jumpToPage(index);
    extraFunction!();
  }
}
