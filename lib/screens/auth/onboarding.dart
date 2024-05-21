import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../helpers/onboarding_items.dart';
import '../../models/onboarding_info.dart';
import '../../services/api_client.dart';
import '../../widgets/auth_widgets/auth_button.dart';
import 'auth_root.dart';

class Onboarding extends StatefulWidget {
  static const routeName = '/Onboarding';

  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  List<OnboardingInfo> controller = OnboardingItems.items;
  final pageController = PageController();

  bool isLastPage = false;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () => ApiClient.setContext(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#141414"),
        centerTitle: true,
        title: Image.asset(
          "assets/logos/logo_full.png",
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
                    count: controller.length,
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
                                ? Navigator.of(context)
                                    .pushNamed(AuthRoot.routeName)
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
      body: PageView.builder(
          onPageChanged: (index) {
            setState(() => isLastPage = controller.length - 1 == index);
            setState(() => currentPage = index);
          },
          itemCount: controller.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80.w,
                    child: Image.asset(
                      controller[index].image,
                    ),
                  ),
                  const SizedBox(height: 30),
                  controller[index].title,
                  const SizedBox(height: 15),
                  Text(
                    controller[index].descriptions,
                    style: TextStyle(
                      color: HexColor("#AEAEAE"),
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
