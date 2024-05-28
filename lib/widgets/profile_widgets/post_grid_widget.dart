import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/constants/app_colors.dart';
import 'package:timeset/helpers/formatter.dart';

class PostGridWidget extends StatefulWidget {
  const PostGridWidget({
    super.key,
    required this.coverImage,
    required this.views,
    this.onTap,
  });
  final Function()? onTap;
  final String coverImage;
  final int views;

  @override
  State<PostGridWidget> createState() => _PostGridWidgetState();
}

class _PostGridWidgetState extends State<PostGridWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  widget.coverImage,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.play_circle_fill_rounded,
                      color: AppColors.primary,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(formatNumber(widget.views))
                  ],
                ),
              ],
            ),
          ),
          // const Row(
          //   children: [
          //     CircleAvatar(
          //       backgroundImage: NetworkImage(""),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
