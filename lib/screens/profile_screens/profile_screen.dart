import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/constants/app_colors.dart';
import 'package:timeset/helpers/formatter.dart';
import 'package:timeset/screens/profile_screens/edit_profile_root.dart';
import 'package:timeset/screens/settings_screens/settings_root.dart';
import 'package:timeset/state_management/user_provider.dart';
import 'package:timeset/widgets/auth_widgets/auth_button.dart';
import 'package:timeset/widgets/profile_widgets/post_grid_widget.dart';
import 'package:timeset/widgets/profile_widgets/sliver_persistent_header_delegate.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        toolbarHeight: 70,
        elevation: 5,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            splashRadius: 50,
            highlightColor: Colors.white10,
            icon: const Icon(
              Icons.store_outlined,
              color: Colors.white,
              size: 26,
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          IconButton(
            splashRadius: 50,
            tooltip: "Settings",
            highlightColor: Colors.white10,
            onPressed: () {
              Navigator.pushNamed(
                context,
                SettingsRoot.routeName,
              );
            },
            icon: Icon(
              Icons.settings_outlined,
              color: AppColors.primary,
              size: 26,
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<UserProvider>(builder: (
          context,
          state,
          child,
        ) {
          final user = state.user;
          return DefaultTabController(
            length: 3,
            child: NestedScrollView(
              headerSliverBuilder: (context, _) {
                return [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            user.image!.isNotEmpty
                                ? CircleAvatar(
                                    backgroundColor: HexColor("#2C2C2C"),
                                    radius: 33.sp,
                                    backgroundImage: NetworkImage(
                                      user.image!,
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor: HexColor("#2C2C2C"),
                                    radius: 33.sp,
                                    child: SvgPicture.asset(
                                      'assets/images/person.svg',
                                      width: 25.sp,
                                    ),
                                  ),
                            Positioned(
                              bottom: -10,
                              right: -10,
                              child: IconButton(
                                constraints: BoxConstraints.tight(
                                  const Size(30, 30),
                                ),
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
                                  size: 13,
                                  color: HexColor("#141414"),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          user.fullName!,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        SizedBox(
                          width: 65.w,
                          child: Text(
                            textAlign: TextAlign.center,
                            user.about!,
                            style: TextStyle(
                              fontSize: 9.sp,
                              height: 1.7,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Divider(
                          color: HexColor("#2C2C2C"),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Metric(
                                title: "Posts",
                                value: formatNumber(user.metrics.totalPosts),
                              ),
                              VerticalDivider(
                                color: HexColor("#2C2C2C"),
                                width: 1,
                              ),
                              Metric(
                                title: "Followers",
                                value:
                                    formatNumber(user.metrics.totalFollowers),
                              ),
                              VerticalDivider(
                                color: HexColor("#2C2C2C"),
                                width: 1,
                              ),
                              Metric(
                                title: "Following",
                                value:
                                    formatNumber(user.metrics.totalFollowing),
                              ),
                              VerticalDivider(
                                color: HexColor("#2C2C2C"),
                                width: 1,
                              ),
                              Metric(
                                title: "Likes",
                                value: formatNumber(user.metrics.totalLikes),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 35,
                            vertical: 30,
                          ),
                          child: AuthButton(
                            text: "Edit Profile",
                            function: () {
                              Navigator.pushNamed(
                                context,
                                EditProfileRoot.routeName,
                              );
                            },
                            bgColor: "#141414",
                            color: "#9CBB30",
                            borderColor: "#9CBB30",
                            customHeight: 5.5,
                            hasCustomIcon: true,
                            customIcon: Icons.edit_rounded,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: SliverAppBarDelegate(
                      minHeight: 50,
                      maxHeight: 50,
                      child: Container(
                        color: AppColors.scaffoldColor,
                        child: TabBar(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0,
                          ),
                          controller: tabController,
                          dividerColor: HexColor("#2C2C2C"),
                          indicatorColor: HexColor("#9CBB30"),
                          labelColor: HexColor("#9CBB30"),
                          unselectedLabelColor: HexColor('#AEAEAE'),
                          labelPadding: const EdgeInsets.only(
                            top: 10,
                            bottom: 15,
                            left: 25,
                            right: 25,
                          ),
                          indicatorSize: TabBarIndicatorSize.label,
                          overlayColor: const WidgetStatePropertyAll(
                            Colors.white10,
                          ),
                          indicator: UnderlineTabIndicator(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              width: 3,
                              color: HexColor("#9CBB30"),
                            ),
                          ),
                          isScrollable: true,
                          tabAlignment: TabAlignment.center,
                          tabs: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: const Icon(
                                Icons.grid_view_rounded,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: const Icon(
                                Icons.library_add_rounded,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: const Icon(
                                Icons.favorite_rounded,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    pinned: true,
                  )
                ];
              },
              body: TabBarView(
                controller: tabController,
                children: [
                  CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.all(20),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return PostGridWidget(
                                coverImage:
                                    "https://picsum.photos/id/${index + 1047}/500/500",
                                views: 3834,
                              );
                            },
                            childCount: 5,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Center(
                    child: Text("Posts"),
                  ),
                  const Center(
                    child: Text("Saved"),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class Metric extends StatelessWidget {
  const Metric({
    super.key,
    required this.value,
    required this.title,
  });

  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 5.w,
        ),
        Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 5.w,
        ),
      ],
    );
  }
}
