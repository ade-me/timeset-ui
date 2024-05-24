import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class LocationSelect extends StatefulWidget {
  const LocationSelect(
      {super.key, required this.title, required this.address, this.onTap});

  final String? title;
  final String? address;
  final Function()? onTap;

  @override
  State<LocationSelect> createState() => _LocationSelectState();
}

class _LocationSelectState extends State<LocationSelect> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.sp),
        child: Row(
          children: [
            CircleAvatar(
              radius: 19.sp,
              backgroundColor: Colors.white10,
              child: Icon(
                Icons.location_on_rounded,
                color: HexColor("#9CBB30"),
                size: 18.sp,
              ),
            ),
            SizedBox(
              width: 4.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 70.w,
                  child: Text(
                    "${widget.title}",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
