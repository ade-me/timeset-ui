import 'package:flutter/material.dart';

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
        const Divider(
          thickness: 0.2,
        ),
        sizedBox,
      ],
    );
  }
}
