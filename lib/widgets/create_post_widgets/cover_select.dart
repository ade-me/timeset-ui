import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CoverSelect extends StatelessWidget {
  const CoverSelect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.all(10.sp),
        height: 95.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: const DecorationImage(
            image: NetworkImage(
              "https://ramseyvoice.com/wp-content/uploads/2020/06/African-American-Man-Singing-in-Microphone.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Text(
          "Select Cover",
          style: TextStyle(
            fontSize: 10.sp,
          ),
        ),
      ),
    );
  }
}
