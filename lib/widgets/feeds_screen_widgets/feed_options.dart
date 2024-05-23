import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/widgets/feeds_screen_widgets/comments_bottom_sheet.dart';
import 'package:timeset/widgets/feeds_screen_widgets/save_post_widget.dart';
import 'package:timeset/widgets/feeds_screen_widgets/song_widget.dart';
import 'package:timeset/widgets/general_widgets/custom_bottom_sheet.dart';

import '../../constants/app_colors.dart';
import '../../widgets/feeds_screen_widgets/option.dart';
import '../../widgets/feeds_screen_widgets/user_details.dart';

class FeedOptions extends StatefulWidget {
  const FeedOptions({super.key});

  @override
  State<FeedOptions> createState() => _FeedOptionsState();
}

class _FeedOptionsState extends State<FeedOptions> {
  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var textStyle = textTheme.bodyMedium?.copyWith(
      fontSize: 11.sp,
    );
    var actionStyle = textStyle?.copyWith(
      fontSize: 11.sp,
      color: AppColors.primary,
    );

    return Container(
      width: 100.w,
      padding: EdgeInsets.all(10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserDetails(
                userInfo: "Actress & Singer",
                userName: "Jenny Wilson",
                userImage:
                    "https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D",
                isFollowing: false,
                onTap: () {},
                onFollow: () {},
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                width: 55.w,
                child: ReadMoreText(
                  "Hi Everyone, in this video i will sing a song #song #music #love #beauty #song #music #love #beauty #song #music #love #beauty #song #music #love #beauty ",
                  trimCollapsedText: ' Read More',
                  trimExpandedText: ' Read Less',
                  moreStyle: actionStyle,
                  lessStyle: actionStyle,
                  trimLength: 55,
                ),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              const SongWidget(title: "Favorite Girl by Justin bieber")
            ],
          ),
          Column(
            children: [
              Option(
                icon: Icons.location_on_rounded,
                text: "Lagos",
                onTap: () {},
              ),
              SizedBox(
                height: 4.h,
              ),
              Option(
                icon: Icons.favorite_rounded,
                text: "140",
                isSelected: true,
                onTap: () {},
              ),
              SizedBox(
                height: 4.h,
              ),
              Option(
                hasCustomIcon: true,
                customIcon: "comment2",
                text: "3.5k",
                onTap: () {
                  CommentsBottomSheet.showBottomSheet(context);
                },
              ),
              SizedBox(
                height: 4.h,
              ),
              Option(
                hasCustomIcon: true,
                customIcon: "bucket",
                onTap: () {
                  CustomBottomSheet.showBottomSheet(
                    context,
                    const SavePostWidget(),
                  );
                },
              ),
              SizedBox(
                height: 4.h,
              ),
              Option(
                hasCustomIcon: true,
                customIcon: "share",
                text: "203",
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
