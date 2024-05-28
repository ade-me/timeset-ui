import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/widgets/general_widgets/circular_loader.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.text,
    required this.function,
    this.isLoading = false,
    this.bgColor = "#9CBB30",
    this.color = "#141414",
    this.isDisabled = false,
    this.hasIcon = false,
    this.icon = "",
    this.grayButton = false,
    this.borderColor = "#00FFFFFF",
    this.customIcon = Icons.abc,
    this.hasCustomIcon = false,
    this.customHeight = 7,
  });

  final String text;
  final String bgColor;
  final String color;
  final bool isLoading;
  final bool isDisabled;
  final Function function;
  final bool hasIcon;
  final bool hasCustomIcon;
  final IconData customIcon;
  final String icon;
  final bool grayButton;
  final String borderColor;
  final double customHeight;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: HexColor(bgColor).withOpacity(isDisabled ? 0.2 : 1),
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: isDisabled
            ? null
            : () {
                function();
              },
        splashColor: Colors.white10,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: customHeight.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: grayButton
                ? Border.all(
                    width: 2,
                    color: HexColor("#2C2C2C"),
                  )
                : Border.all(
                    width: 2,
                    color: HexColor(borderColor),
                  ),
          ),
          child: isLoading == true
              ? const CustomProgressIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    hasIcon
                        ? SvgPicture.asset("assets/icons/$icon.svg")
                        : hasCustomIcon
                            ? Icon(
                                customIcon,
                                color: HexColor(color),
                              )
                            : const SizedBox(),
                    SizedBox(
                      width: hasIcon || hasCustomIcon ? 7.sp : 0,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: HexColor(color),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
