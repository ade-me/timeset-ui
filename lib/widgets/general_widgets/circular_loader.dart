import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
    this.strokeWidth = 1.0,
    this.color = "#141414",
  });

  final double strokeWidth;
  final String color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        color: HexColor(color),
      ),
    );
  }
}
