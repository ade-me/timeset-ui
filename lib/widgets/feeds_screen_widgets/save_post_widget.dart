import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/constants/app_colors.dart';

class SavePostWidget extends StatefulWidget {
  const SavePostWidget({super.key});

  @override
  State<SavePostWidget> createState() => _SavePostWidgetState();
}

class _SavePostWidgetState extends State<SavePostWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(15.sp),
          child: Row(
            children: [
              Icon(
                Icons.bookmark_outline_rounded,
                color: AppColors.primary,
                size: 24.sp,
              ),
              SizedBox(
                width: 3.w,
              ),
              const Text(
                "Save Post",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        Divider(
          color: HexColor("#2C2C2C"),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add items from post to bucket list",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: HexColor("#8E8E8E"),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              const ProductSelect(),
              const ProductSelect(),
            ],
          ),
        ),
      ],
    );
  }
}

class ProductSelect extends StatefulWidget {
  const ProductSelect({
    super.key,
  });

  @override
  State<ProductSelect> createState() => _ProductSelectState();
}

class _ProductSelectState extends State<ProductSelect> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Item 1",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              ),
              Text(
                "Name of vendor",
                style: TextStyle(
                  fontSize: 11.sp,
                  color: HexColor("#8E8E8E"),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 7.sp,
              horizontal: 15.sp,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Add",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 11.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
