import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/product.dart';
import '../../widgets/general_widgets/custom_network_widget.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/general_app_padding.dart';
import '../../widgets/shop_widgets/product_tile.dart';
import '../../widgets/shop_widgets/shop_categories_widget.dart';
import '../../widgets/shop_widgets/trending_deals_widget.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final searchFieldController = TextEditingController();

  final focusNode = FocusNode();

  bool searchHasInput = false;

  @override
  void dispose() {
    searchFieldController.dispose();

    focusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    searchFieldController.addListener(checkSearchInput);
  }

  void checkSearchInput() => setState(
        () => searchFieldController.text.isNotEmpty
            ? searchHasInput = true
            : searchHasInput = false,
      );

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 3.h);

    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var bodySmall = textTheme.bodySmall;

    return Column(
      children: [
        SizedBox(height: 13.h),
        GeneralAppPadding(
          child: SearchTextField(
            controller: searchFieldController,
          ),
        ),
        Expanded(
          child: searchHasInput
              ? ListView.builder(
                  itemCount: 3,
                  itemBuilder: (ctx, index) => const ProductTile(
                    product: Product(
                      price: 0,
                      title: 'Hair Roller (3pcs)',
                      userId: 'userId',
                      ratings: 0,
                      imageUrl:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSvId9ySl-OGP2RQpHH4OOeHelOMCqPP35Xw&usqp=CAU',
                      discount: 0,
                      description:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos',
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBox,
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
