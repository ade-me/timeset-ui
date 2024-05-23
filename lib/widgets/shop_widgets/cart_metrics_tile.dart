import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/general_app_padding.dart';

class CartMetricsTile extends StatelessWidget {
  const CartMetricsTile({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodySmall = textTheme.bodySmall;
    return GeneralAppPadding(
      verticalPadding: 1.5.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: bodySmall,
          ),
          Text(
            value,
            style: bodySmall,
          ),
        ],
      ),
    );
  }
}
