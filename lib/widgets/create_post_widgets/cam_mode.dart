import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CamMode extends StatelessWidget {
  const CamMode({
    super.key,
    this.onTap,
    required this.text,
    required this.icon,
    this.isSelected = false,
  });
  final Function()? onTap;
  final String text;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: !isSelected ? 0.5 : 1,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(
            horizontal: 5.0,
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 140,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5,
                      sigmaY: 5,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(
                          0.2,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.sp,
                        vertical: 5.sp,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            icon,
                            color: Colors.white,
                            size: 13.sp,
                          ),
                          SizedBox(
                            width: 4.sp,
                          ),
                          Text(
                            text,
                            style: TextStyle(
                              fontSize: 11.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
