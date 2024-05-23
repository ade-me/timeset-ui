import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/constants/app_colors.dart';

class SongWidget extends StatefulWidget {
  const SongWidget({super.key, required this.title});
  final String title;

  @override
  State<SongWidget> createState() => _SongWidgetState();
}

class _SongWidgetState extends State<SongWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Icon(
              Icons.album_outlined,
              color: AppColors.primary,
              size: 14.sp,
            ),
            Icon(
              Icons.music_note_rounded,
              color: Colors.white,
              size: 14.sp,
            )
          ],
        ),
        SizedBox(
          width: 2.w,
        ),
        Text(
          widget.title,
          style: TextStyle(fontSize: 11.sp),
        )
      ],
    );
  }
}
