import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../models/country.dart';
import '../../../state_management/country_provider.dart';
import '../../../widgets/auth_widgets/country_list_tile.dart';
import '../../../widgets/auth_widgets/image_selector_option_tile.dart';
import '../../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../../widgets/general_widgets/custom_bottom_sheet.dart';
import '../../../widgets/general_widgets/custom_shimmer.dart';
import '../../../widgets/general_widgets/custom_text_field.dart';
import '../../../widgets/general_widgets/general_app_padding.dart';

class Step4 extends StatefulWidget {
  const Step4(
      {super.key,
      required this.goBack,
      required this.getInputsStatus,
      required this.getFullName,
      required this.getUsername,
      required this.getEmail,
      required this.getPhoneNumber,
      required this.getAddress,
      required this.getSelectedCountry,
      required this.getImageFile,
      required this.currentCountry});

  final Function() goBack;
  final Function(bool) getInputsStatus;
  final Function(String) getFullName;
  final Function(String) getUsername;
  final Function(String) getEmail;
  final Function(String) getPhoneNumber;
  final Function(String) getAddress;
  final Country currentCountry;
  final Function(Country) getSelectedCountry;
  final Function(File?) getImageFile;

  @override
  State<Step4> createState() => _Step4State();
}

class _Step4State extends State<Step4> {
  final fullNameTextController = TextEditingController();
  final usernameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final addressTextController = TextEditingController();

  final fullNameFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final addressFocusNode = FocusNode();

  bool fullNameHasInput = false;
  bool usernameHasInput = false;
  bool emailHasInput = false;
  bool phoneHasInput = false;
  bool addressHasInput = false;

  File? file;

  bool inputsStatus = false;
  List<bool> allInputStatus = [];

  void checkInputsStatus() {
    if (allInputStatus.length == 5) {
      if (allInputStatus.any((element) => element != false)) {
        inputsStatus = true;
      }
    }

    widget.getInputsStatus(inputsStatus);
  }

  void checkFullNameHasInput() {
    setState(() {
      fullNameTextController.text.isNotEmpty
          ? fullNameHasInput = true
          : fullNameHasInput = false;

      allInputStatus.add(fullNameHasInput);
      checkInputsStatus();
    });
  }

  void checkUserNameHasInput() {
    setState(() {
      usernameTextController.text.isNotEmpty
          ? usernameHasInput = true
          : usernameHasInput = false;

      allInputStatus.add(usernameHasInput);
      checkInputsStatus();
    });
  }

  void checkEmailHasInput() {
    setState(() {
      emailTextController.text.isNotEmpty
          ? emailHasInput = true
          : emailHasInput = false;

      allInputStatus.add(emailHasInput);
      checkInputsStatus();
    });
  }

  void checkPhoneHasInput() {
    setState(() {
      phoneTextController.text.isNotEmpty
          ? phoneHasInput = true
          : phoneHasInput = false;

      allInputStatus.add(phoneHasInput);
      checkInputsStatus();
    });
  }

  void checkAddressHasInput() {
    setState(() {
      addressTextController.text.isNotEmpty
          ? addressHasInput = true
          : addressHasInput = false;

      allInputStatus.add(addressHasInput);
      checkInputsStatus();
    });
  }

  void getCountries() {
    Provider.of<CountryProvider>(context, listen: false).getCountryWithCodes();
  }

  @override
  void initState() {
    super.initState();

    phoneTextController.text = widget.currentCountry.dialCode;

    fullNameTextController.addListener(checkFullNameHasInput);
    usernameTextController.addListener(checkUserNameHasInput);
    emailTextController.addListener(checkEmailHasInput);
    phoneTextController.addListener(checkPhoneHasInput);
    addressTextController.addListener(checkAddressHasInput);
  }

  @override
  void dispose() {
    super.dispose();

    fullNameTextController.dispose();
    usernameTextController.dispose();
    emailTextController.dispose();
    phoneTextController.dispose();
    addressTextController.dispose();

    fullNameFocusNode.dispose();
    usernameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    addressFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 4.h);

    return SingleChildScrollView(
      child: GeneralAppPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.h),
            AppBarWithBackButton(
              hasCustomFunction: true,
              function: () {
                widget.goBack();
              },
              title: "Fill Your Profile",
            ),
            sizedBox,
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  file!.existsSync()
                      ? CircleAvatar(
                          backgroundColor: HexColor("#2C2C2C"),
                          radius: 50.sp,
                          backgroundImage: FileImage(file!),
                        )
                      : CircleAvatar(
                          backgroundColor: HexColor("#2C2C2C"),
                          radius: 50.sp,
                          child: SvgPicture.asset(
                            'assets/images/person.svg',
                            width: 43.sp,
                          ),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      color: Colors.white10,
                      style: IconButton.styleFrom(
                        backgroundColor: HexColor("#9CBB30"),
                      ),
                      onPressed: () {
                        showImageSelectorSheet(context);
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 15,
                        color: HexColor("#141414"),
                      ),
                    ),
                  )
                ],
              ),
            ),
            sizedBox,
            CustomTextField(
              textInputType: TextInputType.name,
              textInputAction: TextInputAction.done,
              controller: fullNameTextController,
              focusNode: fullNameFocusNode,
              iconName: 'password',
              hintText: 'Full name',
              hasCustomIcon: true,
              customIcon: Icons.person_4_rounded,
              onEditingComplete: () {
                widget.getFullName(
                  fullNameTextController.text.trim(),
                );
              },
            ),
            SizedBox(
              height: 10.sp,
            ),
            CustomTextField(
              textInputType: TextInputType.name,
              textInputAction: TextInputAction.done,
              controller: usernameTextController,
              focusNode: usernameFocusNode,
              hintText: 'Username',
              hasCustomIcon: true,
              customIcon: Icons.alternate_email_rounded,
              onEditingComplete: () {
                widget.getUsername(
                  usernameTextController.text.trim(),
                );
              },
            ),
            SizedBox(
              height: 10.sp,
            ),
            CustomTextField(
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              controller: emailTextController,
              focusNode: emailFocusNode,
              hintText: 'Email',
              hasCustomIcon: true,
              customIcon: Icons.email_outlined,
              onEditingComplete: () {
                widget.getEmail(
                  emailTextController.text.trim(),
                );
              },
            ),
            SizedBox(
              height: 10.sp,
            ),
            CustomTextField(
              textInputType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              controller: phoneTextController,
              focusNode: phoneFocusNode,
              hintText: '000 000',
              hasCustomIcon: true,
              customIcon: Icons.phone,
              hasDropdown: true,
              minWidth: 27,
              flagUrl:
                  "https://country-code-au6g.vercel.app/${widget.currentCountry.image}",
              onEditingComplete: () {
                widget.getPhoneNumber(
                  phoneTextController.text.trim(),
                );
              },
              onDropdown: () async {
                getCountries();
                phoneTextController.text = '${widget.currentCountry.dialCode} ';
                showCountryBottomSheet();
              },
            ),
            SizedBox(
              height: 10.sp,
            ),
            CustomTextField(
              textInputType: TextInputType.streetAddress,
              textInputAction: TextInputAction.done,
              controller: addressTextController,
              focusNode: addressFocusNode,
              hintText: 'Address',
              hasCustomIcon: true,
              customIcon: Icons.location_on_rounded,
              onEditingComplete: () {
                widget.getAddress(
                  addressTextController.text.trim(),
                );
              },
            ),
            SizedBox(
              height: 10.sp,
            ),
          ],
        ),
      ),
    );
  }

  void showCountryBottomSheet() {
    CustomBottomSheet.showBottomSheet(
      context,
      Consumer<CountryProvider>(
        builder: (context, countryProvider, _) {
          if (countryProvider.isLoading) {
            return Expanded(
              child: ListView.builder(
                itemCount: 15,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (ctx, _) => CustomShimmer(
                  height: 5.h,
                  width: 100.w,
                  margin: EdgeInsets.all(15.sp),
                ),
              ),
            );
          } else {
            return Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: countryProvider.countries.length,
                itemBuilder: (context, index) {
                  final country = countryProvider.countries[index];
                  return CountryListTile(
                    country: country,
                    getCountry: widget.getSelectedCountry,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  void showImageSelectorSheet(BuildContext context) {
    CustomBottomSheet.showBottomSheet(
      context,
      Padding(
        padding: EdgeInsets.symmetric(vertical: 30.sp, horizontal: 20.sp),
        child: Column(
          children: [
            ImageSelectorOptionTIle(
              icon: Icons.camera_alt,
              label: "Take a picture",
              imageSource: ImageSource.camera,
              getImageFile: widget.getImageFile,
            ),
            SizedBox(
              height: 25.sp,
            ),
            ImageSelectorOptionTIle(
              icon: Icons.photo_library,
              label: "Choose from media",
              imageSource: ImageSource.gallery,
              getImageFile: widget.getImageFile,
            ),
          ],
        ),
      ),
    );
  }
}
