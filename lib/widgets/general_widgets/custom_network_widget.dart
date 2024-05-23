import 'package:flutter/widgets.dart';

import 'custom_shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.src,
    this.h,
    this.w,
    this.borderRadius = BorderRadius.zero,
  });

  final BorderRadius borderRadius;
  final String src;
  final double? h;
  final double? w;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.network(
        src,
        height: h,
        width: w,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CustomShimmer(
            height: h ?? 0,
            width: w ?? 0,
          );
        },
        errorBuilder: (ctx, _, stacktrace) {
          return Center(
            child: Image.asset(
              'assets/logos/logo.png',
              height: h,
              width: w,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
