import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/custom_floating_button.dart';
import '../../widgets/general_widgets/general_app_padding.dart';
import '../../widgets/shop_widgets/cart_list_tile.dart';
import '../../widgets/shop_widgets/cart_metrics_tile.dart';

class CheckOutScreen extends StatelessWidget {
  static const routeName = '/CheckOutScreen';

  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodySmall = textTheme.bodySmall;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const GeneralAppPadding(
              child: AppBarWithBackButton(
                title: 'Checkout',
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
            Container(
              padding: EdgeInsets.symmetric(vertical: 1.5.h),
              decoration: const BoxDecoration(
                color: Color(0xFF1A1A1A),
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF2C2C2C),
                  ),
                ),
              ),
              child: const Column(
                children: [
                  CartMetricsTile(
                    label: 'No. of Items',
                    value: '2',
                  ),
                  CartMetricsTile(
                    label: 'Total cost of items',
                    value: '\$298.00 USD',
                  ),
                  CartMetricsTile(
                    label: 'shipping cost',
                    value: '\$1.58 USD',
                  ),
                ],
              ),
            ),
            GeneralAppPadding(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total',
                          style: bodySmall?.copyWith(
                            color: Colors.white60,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          '\$299.58 USD',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                    const CustomFloatingButton(
                      label: 'Checkout',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
