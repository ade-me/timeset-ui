import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class UserSelect extends StatefulWidget {
  const UserSelect({
    super.key,
    required this.userName,
    required this.userImage,
    required this.userInfo,
    this.isSelected = false,
    this.hasDelete = false,
    this.onDelete,
    this.onTap,
  });

  final String userName;
  final String userImage;
  final String userInfo;
  final bool isSelected;
  final bool hasDelete;
  final Function()? onDelete;
  final Function()? onTap;

  @override
  State<UserSelect> createState() => _UserSelectState();
}

class _UserSelectState extends State<UserSelect> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: const NetworkImage(
                    "https://hips.hearstapps.com/hmg-prod/images/ariana_grande_photo_jon_kopaloff_getty_images_465687098.jpg",
                  ),
                  radius: 17.sp,
                ),
                SizedBox(
                  width: 3.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userName,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      widget.userInfo,
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: HexColor("#AEAEAE"),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                widget.isSelected
                    ? Icon(
                        Icons.check,
                        color: HexColor("#9CBB30"),
                      )
                    : const SizedBox(),
                SizedBox(
                  width: widget.hasDelete ? 3.w : 0,
                ),
                widget.hasDelete
                    ? GestureDetector(
                        onTap: widget.onDelete,
                        child: Icon(
                          Icons.delete,
                          color: HexColor("#ffffff"),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
