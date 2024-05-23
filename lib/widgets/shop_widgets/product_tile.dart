import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../../models/product.dart';
import '../../screens/shop_screens/product_screen.dart';
import '../general_widgets/custom_network_widget.dart';
import 'rating_widget.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodySmall = textTheme.bodySmall;

    var titleStyle = bodySmall?.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 11.sp,
    );

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        ProductScreen.routeName,
        arguments: product,
      ),
      splashColor: Colors.white10,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomNetworkImage(
              src: product.imageUrl,
              h: 80.sp,
              w: 80.sp,
              borderRadius: BorderRadius.circular(20),
            ),
            SizedBox(width: 4.w),
            SizedBox(
              width: 35.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: titleStyle,
                  ),
                  SizedBox(height: 1.5.h),
                  Text(
                    product.description,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: bodySmall?.copyWith(
                      color: Colors.white60,
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  const RatingWidget(),
                ],
              ),
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$99.99 USD',
                  style: titleStyle?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 7.sp),
                Text(
                  '\$289.99 USD',
                  style: bodySmall?.copyWith(
                    color: Colors.white60,
                    fontSize: 8.sp,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(height: 36.sp),
                Text(
                  'From Jenny Kins',
                  style: bodySmall?.copyWith(
                    fontSize: 8.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
