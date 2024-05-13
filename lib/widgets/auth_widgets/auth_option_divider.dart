import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class AuthOptionalDivider extends StatelessWidget {
  const AuthOptionalDivider({
    super.key,
    required this.optionText,
  });

  final String optionText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              color: HexColor("#2C2C2C"),
              height: 1.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            child: Text(
              optionText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              color: HexColor("#2C2C2C"),
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
