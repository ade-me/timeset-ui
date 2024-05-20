import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../models/country.dart';

class CountryListTile extends StatelessWidget {
  const CountryListTile({
    super.key,
    required this.country,
    required this.getCountry,
  });

  final Country country;
  final Function(Country) getCountry;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);

          getCountry(country);
        },
        splashColor: Colors.white10,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: 2.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.network(
                    country.imageUrl(),
                    width: 20.sp,
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  Text(
                    country.name,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
              Text(country.dialCode)
            ],
          ),
        ),
      ),
    );
  }
}
