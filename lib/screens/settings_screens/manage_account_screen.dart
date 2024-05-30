import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/formatter.dart';
import '../../widgets/create_post_widgets/options_tile.dart';
import '../../widgets/general_widgets/custom_center_dialog.dart';
import '../../widgets/general_widgets/custom_message_bottom_sheet.dart';
import '../../state_management/user_provider.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/custom_divider.dart';
import '../../widgets/general_widgets/general_app_padding.dart';

class ManageAccountScreen extends StatefulWidget {
  const ManageAccountScreen({
    super.key,
    required this.pageController,
  });
  final PageController pageController;

  @override
  State<ManageAccountScreen> createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (willPop) {
        widget.pageController.jumpTo(6);
      },
      child: Consumer<UserProvider>(
        builder: (context, value, child) {
          final user = value.user;
          return SafeArea(
            child: Column(
              children: [
                GeneralAppPadding(
                  verticalPadding: 3,
                  child: AppBarWithBackButton(
                    title: "Manage Account",
                    hasCustomFunction: true,
                    function: () {
                      widget.pageController.jumpTo(6);
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
                            "Account Information",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Column(children: [
                          OptionsTile(
                            title: "Phone Number",
                            hasCustomIcon: true,
                            trailingText: user.phoneNumber!,
                            customIcon: Icons.phone,
                            onTap: () {
                              widget.pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOutCirc,
                              );
                            },
                          ),
                          OptionsTile(
                            title: "Email",
                            isDisabled: true,
                            hasCustomIcon: true,
                            trailingText: user.email!,
                            customIcon: Icons.email_outlined,
                            onTap: () {},
                          ),
                          OptionsTile(
                            title: "Date of Birth",
                            hasCustomIcon: true,
                            trailingText: formatDate(user.dateOfBirth!),
                            customIcon: Icons.calendar_month_outlined,
                            onTap: () {},
                          ),
                        ]),
                        const CustomDivider(),
                        GeneralAppPadding(
                          verticalPadding: 2.h,
                          child: Text(
                            "Account Control",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.white10,
                          onTap: () {
                            CustomCenterDialog.showCustomDialog(
                              context,
                              "Delete",
                              Colors.red,
                              "Delete Account?",
                              "Confirm your decision to delete your account",
                              () {
                                CustomMessageBottomSheet.showBottomSheet(
                                  context,
                                  "Account Termination",
                                  "Check your email to proceed your account termination process.",
                                  Icons.info_outline_rounded,
                                );
                              },
                            );
                          },
                          child: ListTile(
                            dense: true,
                            visualDensity: const VisualDensity(
                              vertical: -4,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 7.sp),
                            title: Row(
                              children: [
                                const Icon(
                                  Icons.delete_outline_rounded,
                                  color: Colors.red,
                                  size: 28,
                                ),
                                SizedBox(
                                  width: 8.sp,
                                ),
                                Text(
                                  "Delete Account",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 11.5.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
