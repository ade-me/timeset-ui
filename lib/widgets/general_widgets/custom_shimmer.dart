import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    required this.height,
    required this.width,
    this.margin,
  });

  final EdgeInsets? margin;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white38,
      highlightColor: Colors.white10,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        color: Colors.white10,
      ),
    );
  }
}
