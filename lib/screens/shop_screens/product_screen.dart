import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../../models/product.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/custom_app_bar_icon.dart';
import '../../widgets/general_widgets/custom_divider.dart';
import '../../widgets/general_widgets/custom_floating_button.dart';
import '../../widgets/general_widgets/custom_network_widget.dart';
import '../../widgets/general_widgets/general_app_padding.dart';
import '../../widgets/shop_widgets/description_text_widget.dart';
import '../../widgets/shop_widgets/quantity_handle_widget.dart';
import '../../widgets/shop_widgets/rating_widget.dart';
import '../../widgets/shop_widgets/review_list_tile.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/ProductScreen';

  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int quantity = 1;

  void getQuantity(int newQuantity) => setState(() => quantity = newQuantity);

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;

    var sizedBox = SizedBox(height: 2.h);
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GeneralAppPadding(
              child: AppBarWithBackButton(
                actions: [
                  CustomAppBarIcon(
                    function: () {},
                    icon: 'favourite',
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBox,
                    GeneralAppPadding(
                      child: CustomNetworkImage(
                        src: product.imageUrl,
                        h: 30.h,
                        w: 100.w,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    GeneralAppPadding(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/map_pin.svg',
                            height: 2.5.h,
                            width: 2.5.w,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Houston, Texas',
                            style: textTheme.bodySmall,
                          ),
                          const Spacer(),
                          const RatingWidget(),
                        ],
                      ),
                    ),
                    sizedBox,
                    GeneralAppPadding(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                '\$99.99',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          QuantityHandlerWidget(
                            quantity: quantity,
                            getQuantity: getQuantity,
                          ),
                        ],
                      ),
                    ),
                    CustomDivider(
                      height: 3.h,
                    ),
                    GeneralAppPadding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headerText(text: 'Description'),
                          sizedBox,
                          DescriptionTextWidget(
                            description: product.description,
                          ),
                        ],
                      ),
                    ),
                    CustomDivider(
                      height: 3.h,
                    ),
                    GeneralAppPadding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headerText(text: 'Reviews'),
                          sizedBox,
                          const Column(
                            children: [
                              ReviewListTile(),
                              ReviewListTile(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
            const Divider(
              thickness: 0.2,
              height: 0.5,
            ),
            SizedBox(height: 1.h),
            GeneralAppPadding(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.bookmark_outline_rounded,
                      size: 25.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Save to bucket list',
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  const CustomFloatingButton(
                    label: 'Add to cart',
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Text headerText({
    required String text,
  }) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white60,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
