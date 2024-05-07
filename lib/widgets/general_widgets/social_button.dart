import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.text,
    required this.function,
    required this.image,
  });

  final String text;
  final String image;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: () {
          function();
        },
        splashColor: Colors.white10,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: HexColor("#2C2C2C"), width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
