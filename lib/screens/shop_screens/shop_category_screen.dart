import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/product.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/custom_divider.dart';
import '../../widgets/general_widgets/general_app_padding.dart';
import '../../widgets/shop_widgets/product_tile.dart';

class ShopCategoryScreen extends StatefulWidget {
  static const routeName = '/ShopCategoryScreen';

  const ShopCategoryScreen({super.key});

  @override
  State<ShopCategoryScreen> createState() => _ShopCategoryScreenState();
}

class _ShopCategoryScreenState extends State<ShopCategoryScreen> {
  Timer? timer;

  Duration _duration = const Duration(
    days: 3,
    hours: 12,
    minutes: 59,
    seconds: 34,
  );

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
        const Duration(
          seconds: 1,
        ), (timer) {
      setState(() {
        if (_duration.inSeconds > 0) {
          _duration = _duration - const Duration(seconds: 1);
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    timer?.cancel();
  }

  String formatDuration() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String days = _duration.inDays.toString();
    String hours = twoDigits(_duration.inHours.remainder(24));
    String minutes = twoDigits(_duration.inMinutes.remainder(60));
    String seconds = twoDigits(_duration.inSeconds.remainder(60));
    return "$days:$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    const productTile = ProductTile(
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
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GeneralAppPadding(
              child: AppBarWithBackButton(
                title: args['title'],
              ),
            ),
            Container(
              height: 5.h,
              width: 100.w,
              color: Colors.red,
              child: GeneralAppPadding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('🔥 Hot Deals For You'),
                    Text(
                      formatDuration(),
                      style: const TextStyle(letterSpacing: 3),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) => productTile,
                    ),
                    CustomDivider(height: 2.h),
                    ListView.builder(
                      itemCount: 20,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) => productTile,
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
