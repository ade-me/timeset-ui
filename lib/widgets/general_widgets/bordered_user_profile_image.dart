import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class BorderedUserProfileImage extends StatelessWidget {
  const BorderedUserProfileImage({
    super.key,
    this.onTap,
    required this.imageUrl,
    this.h,
    this.w,
  });

  final Function()? onTap;
  final String imageUrl;
  final double? h;
  final double? w;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: h ?? 3.1.h,
        width: w ?? 3.1.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: HexColor("#9CBB30"),
            width: 1,
          ),
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(
              imageUrl,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
