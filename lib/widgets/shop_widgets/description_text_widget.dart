import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';

class DescriptionTextWidget extends StatelessWidget {
  const DescriptionTextWidget({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    var textStyle = textTheme.bodyMedium?.copyWith(
      fontSize: 11.sp,
    );

    var actionStyle = textStyle?.copyWith(
      fontSize: 11.sp,
      color: AppColors.primary,
    );

    return ReadMoreText(
      description,
      style: textStyle,
      trimCollapsedText: ' Read More',
      trimExpandedText: ' Read Less',
      moreStyle: actionStyle,
      lessStyle: actionStyle,
    );
  }
}
