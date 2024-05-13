import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../models/onboarding_info.dart';

class OnboardingItems {
  static List<OnboardingInfo> items = [
    OnboardingInfo(
      title: Text.rich(
        TextSpan(
          style: TextStyle(
            fontSize: 21.sp,
            fontWeight: FontWeight.w600,
          ),
          children: [
            const TextSpan(
              text: "Unleash Your ",
            ),
            TextSpan(
              text: "Creativity ",
              style: TextStyle(
                color: HexColor("#9CBB30"),
              ),
            ),
            const TextSpan(
              text: "and Shopping Needs!",
            ),
          ],
        ),
      ),
      descriptions:
          "TimeSet is where creativity meets shopping. Craft videos and shop seamlessly in one place.",
      image: "assets/images/onboarding1.png",
    ),
    OnboardingInfo(
        title: Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 21.sp,
              fontWeight: FontWeight.w600,
            ),
            children: [
              const TextSpan(
                text: "Discover TimeSet: Videos and Shopping in ",
              ),
              TextSpan(
                text: "Harmony",
                style: TextStyle(color: HexColor("#9CBB30")),
              ),
              const TextSpan(
                text: "!",
              ),
            ],
          ),
        ),
        descriptions:
            "Explore TimeSet for captivating videos and effortless shopping, all in one app.",
        image: "assets/images/onboarding2.png"),
    OnboardingInfo(
      title: Text.rich(
        TextSpan(
          style: TextStyle(
            fontSize: 21.sp,
            fontWeight: FontWeight.w600,
          ),
          children: [
            const TextSpan(
              text: "Create your ",
            ),
            TextSpan(
              text: "personalized ",
              style: TextStyle(color: HexColor("#9CBB30")),
            ),
            const TextSpan(
              text: "timeline, tag locations.",
            ),
          ],
        ),
      ),
      descriptions:
          "Navigate through your memories effortlessly with our interactive map feature.",
      image: "assets/images/onboarding3.png",
    ),
  ];
}
