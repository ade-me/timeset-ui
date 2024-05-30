import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.height = 0,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: height);

    return Column(
      children: [
        sizedBox,
        Divider(
          color: HexColor("#2c2c2c"),
        ),
        sizedBox,
      ],
    );
  }
}
