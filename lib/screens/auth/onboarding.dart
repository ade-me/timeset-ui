import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timeset/helpers/custom_page_route.dart';
import 'package:timeset/screens/auth/auth_root.dart';
import 'package:timeset/widgets/auth_button.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#141414"),
        centerTitle: true,
        title: Image.asset(
          "assets/logo_full.png",
          width: 30.w,
        ),
        toolbarHeight: 60,
      ),
      bottomNavigationBar: Container(
        color: HexColor("#141414"),
        child: Row(
          children: [
            Container(
              width: 100.w,
              padding: const EdgeInsets.only(
                bottom: 30,
                left: 20,
                right: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    onDotClicked: (index) => pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeIn,
                    ),
                    effect: WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: HexColor("#ffffff"),
                      dotColor: const Color.fromRGBO(255, 255, 255, 0.3),
                    ),
                  ),

                  //Next Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      currentPage != 0
                          ? Flexible(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(top: 30),
                                child: AuthButton(
                                  color: "#ffffff",
                                  bgColor: "#2C2C2C",
                                  text: "Back",
                                  function: () => pageController.previousPage(
                                    duration: const Duration(
                                      milliseconds: 600,
                                    ),
                                    curve: Curves.easeInOutCirc,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      currentPage != 0
                          ? const SizedBox(
                              width: 10,
                            )
                          : const SizedBox(),
                      Flexible(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: AuthButton(
                            text: "Continue",
                            function: () => isLastPage
                                ? Navigator.of(context).push(
                                    CustomPageRoute(
                                      const AuthRoot(),
                                    ),
                                  )
                                : pageController.nextPage(
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeInOutCirc,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: PageView.builder(
            onPageChanged: (index) {
              setState(() => isLastPage = controller.items.length - 1 == index);
              setState(() => currentPage = index);
            },
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 80.w,
                      child: Image.asset(
                        controller.items[index].image,
                      ),
                    ),
                    const SizedBox(height: 30),
                    controller.items[index].title,
                    const SizedBox(height: 15),
                    Text(
                      controller.items[index].descriptions,
                      style: TextStyle(
                        color: HexColor("#AEAEAE"),
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class OnboardingInfo {
  final Widget title;
  final String descriptions;
  final String image;

  OnboardingInfo(
      {required this.title, required this.descriptions, required this.image});
}

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
      title: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 30,
            fontFamily: "pjs-bold",
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
      image: "assets/onboarding1.png",
    ),
    OnboardingInfo(
        title: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 30,
              fontFamily: "pjs-bold",
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
        image: "assets/onboarding2.png"),
    OnboardingInfo(
      title: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 30,
            fontFamily: "pjs-bold",
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
      image: "assets/onboarding3.png",
    ),
  ];
}
