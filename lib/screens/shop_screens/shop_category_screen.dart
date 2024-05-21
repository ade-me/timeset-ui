import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/screens/shop_screens/shop_screen.dart';

import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/general_app_padding.dart';

class ShopCategoryScreen extends StatefulWidget {
  static const routeName = '/ShopCategoryScreen';

  const ShopCategoryScreen({super.key});

  @override
  State<ShopCategoryScreen> createState() => _ShopCategoryScreenState();
}

class _ShopCategoryScreenState extends State<ShopCategoryScreen> {
  Timer? timer;

  String countdown = '';

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(
        days: 3,
        hours: 12,
        minutes: 59,
        seconds: 34,
      ),
      (timer) => setState(
        () => countdown = timer.toString(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    print(countdown);

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
                    Text(countdown),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Row(
                children: [
                  CustomNetworkImage(
                    src:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSvId9ySl-OGP2RQpHH4OOeHelOMCqPP35Xw&usqp=CAU',
                    h: 15.h,
                    w: 30.w,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  SizedBox(width: 1.w),
                  Column(
                    children: [
                      Text('Hair Roller(3pcs)'),
                      Text(
                          'Product description ipsum dolor sit amet, consectetur adipis...'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
