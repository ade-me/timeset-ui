import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/auth_widgets/gender_select.dart';
import '../../helpers/profile_interest_items.dart';
import '../../widgets/auth_widgets/custom_chip.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/general_app_padding.dart';
import '../../widgets/auth_widgets/auth_button.dart';

class FillProfileScreen extends StatefulWidget {
  static const routeName = '/FillProfileScreen';
  const FillProfileScreen({super.key});

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  final pageViewController = PageController();
  List<String> profileInterests = ProfileInterestItems.items;

  int currentPage = 0;
  List<String> selectedProfileInterests = [];
  String gender = "";
  DateTime dateOfBirth = DateTime.now();

  void handlePageViewChanged(int currentPageIndex) {
    setState(() {
      currentPage = currentPageIndex;
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 4.h);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageViewController,
                onPageChanged: handlePageViewChanged,
                children: [
                  SingleChildScrollView(
                    child: GeneralAppPadding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          const AppBarWithBackButton(
                            title: "Choose your interest",
                          ),
                          Text(
                            'Choose your interest and get the best video, shop, discovery recommendations',
                            style: textTheme.bodySmall,
                          ),
                          sizedBox,
                          Wrap(
                            spacing: 6.sp,
                            runSpacing: 9.sp,
                            children: profileInterests
                                .map(
                                  (e) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        !selectedProfileInterests.contains(e)
                                            ? selectedProfileInterests.add(e)
                                            : selectedProfileInterests
                                                .remove(e);
                                      });
                                    },
                                    child: CustomChip(
                                      text: e,
                                      isSelected:
                                          selectedProfileInterests.contains(e),
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: GeneralAppPadding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          AppBarWithBackButton(
                            hasCustomFunction: true,
                            function: () {
                              pageViewController.previousPage(
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeInOutCirc,
                              );
                            },
                            title: "Tell us about yourself",
                          ),
                          Text(
                            'Choose your identity and help us find accurate contents for you',
                            style: textTheme.bodySmall,
                          ),
                          sizedBox,
                          sizedBox,
                          SizedBox(
                            width: 100.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      gender = "male";
                                    });
                                  },
                                  child: GenderSelect(
                                    isSelected: gender == "male" ? true : false,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.sp,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      gender = "female";
                                    });
                                  },
                                  child: GenderSelect(
                                    isMale: false,
                                    isSelected:
                                        gender == "female" ? true : false,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: GeneralAppPadding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          AppBarWithBackButton(
                            hasCustomFunction: true,
                            function: () {
                              pageViewController.previousPage(
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeInOutCirc,
                              );
                            },
                            title: "When is your birthday?",
                          ),
                          Text(
                            'Your birthday will not be shown to the public',
                            style: textTheme.bodySmall,
                          ),
                          sizedBox,
                          sizedBox,
                          Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/images/birthday.svg',
                              width: 55.w,
                            ),
                          ),
                          sizedBox,
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.sp,
                              vertical: 12.sp,
                            ),
                            decoration: BoxDecoration(
                              color: HexColor("#222222"),
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                  color: HexColor("#2C2C2C"), width: 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${dateOfBirth.month}/${dateOfBirth.day}/${dateOfBirth.year}",
                                ),
                                const Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                            width: 100.w,
                            child: CupertinoTheme(
                              data: CupertinoThemeData(
                                textTheme: CupertinoTextThemeData(
                                  dateTimePickerTextStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontFamily: "pjs",
                                  ),
                                ),
                              ),
                              child: CupertinoDatePicker(
                                itemExtent: 50,
                                initialDateTime: dateOfBirth,
                                mode: CupertinoDatePickerMode.date,
                                use24hFormat: true,
                                onDateTimeChanged: (DateTime newDate) {
                                  setState(
                                    () => dateOfBirth = newDate,
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.w),
              child: AuthButton(
                text: 'Continue',
                isDisabled: currentPage == 0 && selectedProfileInterests.isEmpty
                    ? true
                    : currentPage == 1 && gender.isEmpty
                        ? true
                        : false,
                function: () {
                  pageViewController.nextPage(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOutCirc,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
