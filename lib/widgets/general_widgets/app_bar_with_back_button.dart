import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class AppBarWithBackButton extends StatelessWidget {
  const AppBarWithBackButton({
    super.key,
    this.title = "",
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.sp, vertical: 10.sp),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // back button
          Row(
            children: [
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  splashColor: Colors.white10,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: HexColor("#2C2C2C"), width: 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: HexColor("#ffffff"),
                    ),
                  ),
                ),
              )
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
