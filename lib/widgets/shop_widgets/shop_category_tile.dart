import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../screens/shop_screens/shop_category_screen.dart';
import '../general_widgets/custom_network_widget.dart';

class ShopCategoryTile extends StatelessWidget {
  const ShopCategoryTile({
    super.key,
    required this.index,
    required this.imageUrl,
    required this.label,
  });

  final int index;
  final String imageUrl;
  final String label;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var bodySmall = textTheme.bodySmall;

    var borderRadius = BorderRadius.circular(15);

    return Padding(
      padding: EdgeInsets.only(
        left: index == 0 ? 5.w : 0,
        right: 5.w,
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          ShopCategoryScreen.routeName,
          arguments: {
            'title': label,
          },
        ),
        borderRadius: borderRadius,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNetworkImage(
              src: imageUrl,
              h: 15.h,
              w: 35.w,
              borderRadius: borderRadius,
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
