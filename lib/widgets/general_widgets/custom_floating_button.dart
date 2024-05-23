import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  final String label;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return SizedBox(
      height: 5.h,
      child: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        extendedPadding: EdgeInsets.symmetric(horizontal: 8.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        heroTag: label.toLowerCase(),
        onPressed: onPressed,
        label: Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 11.sp,
          ),
        ),
      ),
    );
  }
}
