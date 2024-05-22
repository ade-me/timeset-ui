import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/general_widgets/custom_shimmer.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/general_app_padding.dart';
import 'shop_category_screen.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final searchFieldController = TextEditingController();

  final focusNode = FocusNode();

  @override
  void dispose() {
    searchFieldController.dispose();

    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 3.h);

    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var bodySmall = textTheme.bodySmall;

    return Column(
      children: [
        sizedBox,
        GeneralAppPadding(
          child: SearchTextField(
            controller: searchFieldController,
          ),
        ),
        sizedBox,
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // sizedBox,
                GeneralAppPadding(
                  child: CustomNetworkImage(
                    src:
                        'https://images.pexels.com/videos/5310858/pexels-photo-5310858.jpeg?auto=compress&cs=tinysrgb&w=600',
                    h: 20.h,
                    w: 100.w,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                SizedBox(height: 2.h),
                GeneralAppPadding(
                  child: Text(
                    'The best of items handpicked for you! Explore todays trending pieces and elevate your shopping experience',
                    style: bodySmall?.copyWith(fontSize: 9.sp),
                  ),
                ),
                sizedBox,
                ShopCategoriesWidget(
                  sizedBox: sizedBox,
                ),
                sizedBox,
                TrendingDealsWidget(
                  sizedBox: sizedBox,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

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
            height: 20.h,
            width: 100.w,
          );
        },
        errorBuilder: (ctx, _, stacktrace) {
          return Center(
            child: Image.asset('assets/logos/logo.png'),
          );
        },
      ),
    );
  }
}

class TrendingDealsWidget extends StatelessWidget {
  const TrendingDealsWidget({
    super.key,
    required this.sizedBox,
  });

  final Widget sizedBox;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralAppPadding(
          child: Text(
            'Shop Trending Deals',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            ),
          ),
        ),
        sizedBox,
        SizedBox(
          width: 100.w,
          height: 20.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (ctx, index) => ShopCategoryTile(
              index: index,
              label: 'Free Shipping',
              imageUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmV3yqPclar8u5Mv3m0QVISzUIwlNRV43yNg&usqp=CAU',
            ),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}

class ShopCategoriesWidget extends StatelessWidget {
  const ShopCategoriesWidget({
    super.key,
    required this.sizedBox,
  });

  final Widget sizedBox;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralAppPadding(
          child: Text(
            'Shop by categories',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            ),
          ),
        ),
        sizedBox,
        SizedBox(
          width: 100.w,
          height: 20.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (ctx, index) => ShopCategoryTile(
              index: index,
              label: 'Women\' Fashion',
              imageUrl:
                  'https://images.pexels.com/videos/5310858/pexels-photo-5310858.jpeg?auto=compress&cs=tinysrgb&w=600',
            ),
          ),
        ),
      ],
    );
  }
}

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
