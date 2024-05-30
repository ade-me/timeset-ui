import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/general_app_padding.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({
    super.key,
    required this.pageController,
  });
  final PageController pageController;

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  bool accountIsPrivate = false;
  bool suggestAccountToFollow = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (willPop) {
        widget.pageController.jumpTo(0);
      },
      child: Container(
        color: AppColors.primary,
        child: SafeArea(
          child: Column(
            children: [
              GeneralAppPadding(
                verticalPadding: 3,
                child: AppBarWithBackButton(
                  title: "Privacy",
                  color: "#141414",
                  hasCustomFunction: true,
                  function: () {
                    widget.pageController.jumpTo(0);
                  },
                ),
              ),
              SizedBox(
                height: 1.w,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60.w,
                      padding: EdgeInsets.all(3.sp),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: HexColor("#141414"),
                          width: 14.sp,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: QrImageView(
                        data: 'https://google.com',
                        dataModuleStyle: QrDataModuleStyle(
                          color: HexColor(
                            "#141414",
                          ),
                          dataModuleShape: QrDataModuleShape.square,
                        ),
                        eyeStyle: QrEyeStyle(
                          color: HexColor(
                            "#141414",
                          ),
                          eyeShape: QrEyeShape.square,
                        ),
                        gapless: true,
                        errorStateBuilder: (cxt, err) {
                          return const Center(
                            child: Text(
                              'Uh oh! Something went wrong...',
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "@pysavant_",
                      style: TextStyle(
                        color: HexColor(
                          "#141414",
                        ),
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                      ),
                    )
                  ],
                ),
              ),
              GeneralAppPadding(
                verticalPadding: 4.h,
                child: AuthButton(
                  text: "Scan QR Code",
                  function: () {},
                  bgColor: "#141414",
                  color: "#ffffff",
                  hasCustomIcon: true,
                  customIcon: Icons.qr_code_rounded,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
