import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../../models/product.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/custom_app_bar_icon.dart';
import '../../widgets/general_widgets/custom_divider.dart';
import '../../widgets/general_widgets/custom_network_widget.dart';
import '../../widgets/general_widgets/general_app_padding.dart';
import '../../widgets/shop_widgets/rating_widget.dart';

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
                  SizedBox(
                    height: 5.h,
                    child: FloatingActionButton.extended(
                      backgroundColor: AppColors.primary,
                      extendedPadding: EdgeInsets.symmetric(horizontal: 8.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      heroTag: 'add cart',
                      onPressed: () {},
                      label: Text(
                        'Add to cart',
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
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

class ReviewListTile extends StatelessWidget {
  const ReviewListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF212121),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF2C2C2C),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
      margin: EdgeInsets.only(bottom: 2.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18.sp,
                backgroundImage: const NetworkImage(
                  'https://images.pexels.com/photos/992734/pexels-photo-992734.jpeg?auto=compress&cs=tinysrgb&w=600',
                ),
              ),
              SizedBox(width: 3.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Uwak Daniel',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '23/05/2024',
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const RatingWidget(),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et.',
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

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

class QuantityHandlerWidget extends StatefulWidget {
  const QuantityHandlerWidget({
    super.key,
    required this.quantity,
    required this.getQuantity,
  });

  final int quantity;
  final Function(int) getQuantity;

  @override
  State<QuantityHandlerWidget> createState() => _QuantityHandlerWidgetState();
}

class _QuantityHandlerWidgetState extends State<QuantityHandlerWidget> {
  int quantity = 1;

  @override
  void initState() {
    quantity = widget.quantity;

    super.initState();
  }

  void incrementQuantity() => setState(() => quantity = ++quantity);
  void decrementQuantity() =>
      setState(() => quantity > 1 ? quantity = --quantity : null);

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(width: 5.w);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: HexColor('#2C2C2C'),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Row(
        children: [
          actionIcon(
            icon: Icons.remove_rounded,
            onTap: decrementQuantity,
          ),
          sizedBox,
          Text(
            quantity.toString(),
            style: TextStyle(
              fontSize: 8.sp,
            ),
          ),
          sizedBox,
          actionIcon(
            icon: Icons.add_rounded,
            onTap: incrementQuantity,
          ),
        ],
      ),
    );
  }

  InkWell actionIcon({
    required IconData icon,
    required Function onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap();
        widget.getQuantity(quantity);
      },
      child: Icon(
        icon,
        color: Colors.white,
        size: 14.sp,
      ),
    );
  }
}
