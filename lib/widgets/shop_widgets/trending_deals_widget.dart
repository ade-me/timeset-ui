import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/general_app_padding.dart';
import 'shop_category_tile.dart';

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
