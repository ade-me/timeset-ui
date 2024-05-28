import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/widgets/homescreen_widgets/custom_homeplus_popup.dart';

import 'bottom_nav_icon.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    super.key,
    required this.feedsPageCtr,
    required this.pageController,
    required this.currentIndex,
  });

  final PageController pageController;
  final PageController feedsPageCtr;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.sp),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomNavIcon(
              activeIconUrl: "assets/icons/home_active.svg",
              inActiveIconUrl: "assets/icons/home_inactive.svg",
              pageController: pageController,
              index: 0,
              currentIndex: currentIndex,
              extraFunction: () => feedsPageCtr.jumpTo(0),
            ),
            BottomNavIcon(
              activeIconUrl: "assets/icons/search_active.svg",
              inActiveIconUrl: "assets/icons/search_inactive.svg",
              pageController: pageController,
              index: 1,
              currentIndex: currentIndex,
            ),
            IconButton(
              style: ButtonStyle(
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.all(8),
                ),
                backgroundColor: WidgetStatePropertyAll(
                  HexColor("#9CBB30"),
                ),
              ),
              splashColor: Colors.white10,
              onPressed: () {
                CustomHomePlusPopUp.showHomePlusPopup(context);
              },
              icon: Icon(
                Icons.add,
                size: 12.sp,
                color: Colors.black,
              ),
            ),
            BottomNavIcon(
              activeIconUrl: "assets/icons/message_active.svg",
              inActiveIconUrl: "assets/icons/message_inactive.svg",
              pageController: pageController,
              index: 2,
              currentIndex: currentIndex,
            ),
            GestureDetector(
              onTap: () {
                pageController.jumpToPage(3);
              },
              child: Container(
                height: 3.1.h,
                width: 3.1.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.h),
                  border: Border.all(
                    color: HexColor("#9CBB30"),
                    width: 1,
                  ),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
