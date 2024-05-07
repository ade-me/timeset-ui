import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/widgets/general_widgets/circular_loader.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {super.key,
      required this.text,
      required this.function,
      this.isLoading = false,
      this.bgColor = "#9CBB30",
      this.color = "#141414"});

  final String text;
  final String bgColor;
  final String color;
  final bool isLoading;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: HexColor(bgColor),
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: () {
          function();
        },
        splashColor: Colors.white10,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 7.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: isLoading == true
              ? const CustomProgressIndicator()
              : Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: HexColor(color),
                  ),
                ),
        ),
      ),
    );
  }
}
