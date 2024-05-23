import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/screens/shop_screens/product_screen.dart';

import '../../constants/app_colors.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/custom_network_widget.dart';
import '../../widgets/general_widgets/general_app_padding.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const GeneralAppPadding(
              child: AppBarWithBackButton(
                title: 'Cart',
                centerTitle: true,
              ),
            ),
            Expanded(
              child: ListView(
                children: const [
                  CartListTile(),
                  CartListTile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartListTile extends StatelessWidget {
  const CartListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodySmall = textTheme.bodySmall;

    var titleStyle = bodySmall?.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 11.sp,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomNetworkImage(
            src:
                'https://images.pexels.com/photos/12835312/pexels-photo-12835312.jpeg?auto=compress&cs=tinysrgb&w=600',
            h: 80.sp,
            w: 80.sp,
            borderRadius: BorderRadius.circular(20),
          ),
          SizedBox(width: 1.w),
          SizedBox(
            width: 35.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wrist Watch',
                  style: titleStyle,
                ),
                SizedBox(height: 1.5.h),
                Text(
                  'Product description ipsum dolor sit amet, consectetur adipis Product description ipsum dolor sit amet, consectetur adipis',
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: bodySmall?.copyWith(
                    color: Colors.white60,
                  ),
                ),
                SizedBox(height: 1.5.h),
                Text(
                  '\$99.99 USD',
                  style: titleStyle?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.sp),
              QuantityHandlerWidget(
                quantity: 1,
                getQuantity: (_) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
