import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class TagChip extends StatefulWidget {
  const TagChip(
      {super.key, required this.onTap, required this.text, required this.icon});

  final Function()? onTap;
  final String text;
  final IconData icon;

  @override
  State<TagChip> createState() => _TagChipState();
}

class _TagChipState extends State<TagChip> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap;
      },
      splashColor: Colors.white10,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.sp,
          vertical: 6.sp,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: HexColor("#9CBB30"),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              color: HexColor("#9CBB30"),
              size: 12.sp,
            ),
            SizedBox(
              width: 5.sp,
            ),
            Text(
              widget.text,
              style: TextStyle(
                color: HexColor("#9CBB30"),
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
