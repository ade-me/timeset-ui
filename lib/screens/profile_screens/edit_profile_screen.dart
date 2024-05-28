import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/constants/app_colors.dart';
import 'package:timeset/state_management/user_provider.dart';
import 'package:timeset/widgets/create_post_widgets/options_tile.dart';
import 'package:timeset/widgets/general_widgets/app_bar_with_back_button.dart';
import 'package:timeset/widgets/general_widgets/general_app_padding.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen(
      {super.key, required this.pageController, required this.setter});
  final PageController pageController;
  final Function(Map<String, String>) setter;

  @override
  State<EditProfileScreen> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const GeneralAppPadding(
            verticalPadding: 3,
            child: AppBarWithBackButton(
              title: "Edit Profile",
            ),
          ),
          SizedBox(
            height: 1.w,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Consumer<UserProvider>(builder: (
                context,
                state,
                child,
              ) {
                final user = state.user;
                return Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        user.image!.isNotEmpty
                            ? CircleAvatar(
                                backgroundColor: HexColor("#2C2C2C"),
                                radius: 50.sp,
                                backgroundImage: NetworkImage(
                                  user.image!,
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: HexColor("#2C2C2C"),
                                radius: 50.sp,
                                child: SvgPicture.asset(
                                  'assets/images/person.svg',
                                  width: 40.sp,
                                ),
                              ),
                        Positioned(
                          bottom: -5,
                          right: -5,
                          child: IconButton(
                            splashColor: Colors.white10,
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: StadiumBorder(
                                side: BorderSide(
                                  color: AppColors.scaffoldColor,
                                  width: 2,
                                ),
                              ),
                            ),
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit,
                              size: 17,
                              color: HexColor("#141414"),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Divider(
                      color: HexColor("#2C2C2C"),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      width: 100.w,
                      child: Text(
                        "About you",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    OptionsTile(
                      title: "Name",
                      hasCustomIcon: true,
                      customIcon: Icons.account_circle_outlined,
                      trailingText: user.fullName!,
                      onTap: () {
                        widget.setter({
                          "title": "name",
                          "fieldToUpdate": "fullName",
                        });
                        widget.pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOutCirc,
                        );
                      },
                    ),
                    OptionsTile(
                      title: "Username",
                      hasCustomIcon: true,
                      customIcon: Icons.alternate_email_rounded,
                      trailingText: user.username!,
                      onTap: () {
                        widget.setter({
                          "title": "username",
                          "fieldToUpdate": "username",
                        });
                        widget.pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOutCirc,
                        );
                      },
                    ),
                    OptionsTile(
                      title: "Bio",
                      hasCustomIcon: true,
                      customIcon: Icons.info_outline_rounded,
                      trailingText: user.about!,
                      onTap: () {
                        widget.setter({
                          "title": "bio",
                          "fieldToUpdate": "about",
                        });
                        widget.pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOutCirc,
                        );
                      },
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
