import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../../extensions/all_extensions.dart';
import '../../models/language.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/custom_divider.dart';
import '../../widgets/general_widgets/general_app_padding.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({
    super.key,
    required this.pageController,
  });
  final PageController pageController;

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  Language _selectedLanguage = Language.english;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (willPop) {
        widget.pageController.jumpTo(0);
      },
      child: SafeArea(
        child: Column(
          children: [
            GeneralAppPadding(
              verticalPadding: 3,
              child: AppBarWithBackButton(
                title: "Language",
                hasCustomFunction: true,
                function: () {
                  widget.pageController.jumpTo(0);
                },
              ),
            ),
            SizedBox(
              height: 1.w,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GeneralAppPadding(
                      verticalPadding: 2.h,
                      child: Text(
                        "Suggested",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Column(
                      children: Language.values.sublist(0, 2).map((language) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedLanguage = language;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 5.w,
                              top: 4.sp,
                              bottom: 4.sp,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    language.toShortString().capitalize(),
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                ),
                                Radio<Language>(
                                  activeColor: AppColors.primary,
                                  value: language,
                                  groupValue: _selectedLanguage,
                                  onChanged: (selectedLanguage) {
                                    setState(() {
                                      _selectedLanguage = selectedLanguage!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const CustomDivider(),
                    GeneralAppPadding(
                      verticalPadding: 2.h,
                      child: Text(
                        "Language",
                        style: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Column(
                      children: Language.values.map((language) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedLanguage = language;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 5.w,
                              top: 4.sp,
                              bottom: 4.sp,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    language.toShortString().capitalize(),
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                ),
                                Radio<Language>(
                                  activeColor: AppColors.primary,
                                  value: language,
                                  groupValue: _selectedLanguage,
                                  onChanged: (selectedLanguage) {
                                    setState(() {
                                      _selectedLanguage = selectedLanguage!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
