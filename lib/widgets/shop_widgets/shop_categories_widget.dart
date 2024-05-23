import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/general_app_padding.dart';
import 'shop_category_tile.dart';

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
