import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/models/country.dart';
import 'package:timeset/state_management/country_provider.dart';
import 'package:timeset/widgets/general_widgets/custom_bottom_sheet.dart';
import 'package:timeset/widgets/general_widgets/custom_text_field.dart';

import '../../widgets/auth_widgets/gender_select.dart';
import '../../helpers/profile_interest_items.dart';
import '../../widgets/auth_widgets/custom_chip.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/general_app_padding.dart';
import '../../widgets/auth_widgets/auth_button.dart';

class FillProfileScreen extends StatefulWidget {
  static const routeName = '/FillProfileScreen';
  const FillProfileScreen({super.key});

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  final pageViewController = PageController();
  final fullNameTextController = TextEditingController();
  final usernameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final addressTextController = TextEditingController();

  List<String> profileInterests = ProfileInterestItems.items;

  final fullNameFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final addressFocusNode = FocusNode();

  int currentPage = 0;
  List<String> selectedProfileInterests = [];
  String gender = "";
  DateTime dateOfBirth = DateTime.now();
  bool fullNameHasInput = false;
  bool usernameHasInput = false;
  bool emailHasInput = false;
  bool phoneHasInput = false;
  bool addressHasInput = false;
  Country selectedCountry = const Country(
    code: "US",
    name: "name",
    image: "US.svg",
    dialCode: "+1",
  );

  void checkFullNameHasInput() =>
      setState(() => fullNameTextController.text.isNotEmpty
          ? fullNameHasInput = true
          : fullNameHasInput = false);

  void checkUserNameHasInput() =>
      setState(() => usernameTextController.text.isNotEmpty
          ? usernameHasInput = true
          : usernameHasInput = false);

  void checkEmailHasInput() =>
      setState(() => emailTextController.text.isNotEmpty
          ? emailHasInput = true
          : emailHasInput = false);

  void checkPhoneHasInput() =>
      setState(() => phoneTextController.text.isNotEmpty
          ? phoneHasInput = true
          : phoneHasInput = false);

  void checkAddressHasInput() =>
      setState(() => addressTextController.text.isNotEmpty
          ? addressHasInput = true
          : addressHasInput = false);

  void handlePageViewChanged(int currentPageIndex) {
    setState(() {
      currentPage = currentPageIndex;
    });
  }

  void goBack() {
    pageViewController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCirc,
    );
  }

  void nextPage() {
    pageViewController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCirc,
    );
  }

  void getCountries() {
    Provider.of<CountryProvider>(context, listen: false).getCountryWithCodes();
  }

  @override
  void initState() {
    super.initState();

    phoneTextController.text = selectedCountry.dialCode;

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
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageViewController,
                onPageChanged: handlePageViewChanged,
                children: [
                  SingleChildScrollView(
                    child: GeneralAppPadding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          const AppBarWithBackButton(
                            title: "Choose your interest",
                          ),
                          Text(
                            'Choose your interest and get the best video, shop, discovery recommendations',
                            style: textTheme.bodySmall,
                          ),
                          sizedBox,
                          Wrap(
                            spacing: 6.sp,
                            runSpacing: 9.sp,
                            children: profileInterests
                                .map(
                                  (e) => GestureDetector(
                                    onTap: () {
                                      setState(
                                        () {
                                          !selectedProfileInterests.contains(e)
                                              ? selectedProfileInterests.add(e)
                                              : selectedProfileInterests
                                                  .remove(e);
                                        },
                                      );
                                    },
                                    child: CustomChip(
                                      text: e,
                                      isSelected:
                                          selectedProfileInterests.contains(e),
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: GeneralAppPadding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          AppBarWithBackButton(
                            hasCustomFunction: true,
                            function: () {
                              goBack();
                            },
                            title: "Tell us about yourself",
                          ),
                          Text(
                            'Choose your identity and help us find accurate contents for you',
                            style: textTheme.bodySmall,
                          ),
                          sizedBox,
                          sizedBox,
                          SizedBox(
                            width: 100.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      gender = "male";
                                    });
                                  },
                                  child: GenderSelect(
                                    isSelected: gender == "male" ? true : false,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.sp,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      gender = "female";
                                    });
                                  },
                                  child: GenderSelect(
                                    isMale: false,
                                    isSelected:
                                        gender == "female" ? true : false,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: GeneralAppPadding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          AppBarWithBackButton(
                            hasCustomFunction: true,
                            function: () {
                              goBack();
                            },
                            title: "When is your birthday?",
                          ),
                          Text(
                            'Your birthday will not be shown to the public',
                            style: textTheme.bodySmall,
                          ),
                          sizedBox,
                          sizedBox,
                          Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/images/birthday.svg',
                              width: 55.w,
                            ),
                          ),
                          sizedBox,
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.sp,
                              vertical: 12.sp,
                            ),
                            decoration: BoxDecoration(
                              color: HexColor("#222222"),
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: HexColor("#2C2C2C"),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${dateOfBirth.month}/${dateOfBirth.day}/${dateOfBirth.year}",
                                ),
                                const Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                            width: 100.w,
                            child: CupertinoTheme(
                              data: CupertinoThemeData(
                                textTheme: CupertinoTextThemeData(
                                  dateTimePickerTextStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontFamily: "pjs",
                                  ),
                                ),
                              ),
                              child: CupertinoDatePicker(
                                itemExtent: 50,
                                initialDateTime: dateOfBirth,
                                mode: CupertinoDatePickerMode.date,
                                use24hFormat: true,
                                onDateTimeChanged: (DateTime newDate) {
                                  setState(
                                    () => dateOfBirth = newDate,
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: GeneralAppPadding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          AppBarWithBackButton(
                            hasCustomFunction: true,
                            function: () {
                              goBack();
                            },
                            title: "Fill Your Profile",
                          ),
                          sizedBox,
                          Align(
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                CircleAvatar(
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
                                      CustomBottomSheet.showBottomSheet(
                                        context,
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 30.sp,
                                              horizontal: 20.sp),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.camera_alt,
                                                    color: HexColor("#9CBB30"),
                                                  ),
                                                  SizedBox(
                                                    width: 10.sp,
                                                  ),
                                                  const Text("Take a picture")
                                                ],
                                              ),
                                              SizedBox(
                                                height: 25.sp,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.photo_library,
                                                    color: HexColor("#9CBB30"),
                                                  ),
                                                  SizedBox(
                                                    width: 10.sp,
                                                  ),
                                                  const Text(
                                                      "Choose from media")
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
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
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          CustomTextField(
                            textInputType: TextInputType.name,
                            textInputAction: TextInputAction.done,
                            controller: usernameTextController,
                            focusNode: usernameFocusNode,
                            iconName: 'password',
                            hintText: 'Username',
                            hasCustomIcon: true,
                            customIcon: Icons.alternate_email_rounded,
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          CustomTextField(
                            textInputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            controller: emailTextController,
                            focusNode: emailFocusNode,
                            iconName: 'password',
                            hintText: 'Email',
                            hasCustomIcon: true,
                            customIcon: Icons.email_outlined,
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          CustomTextField(
                            textInputType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            controller: phoneTextController,
                            focusNode: phoneFocusNode,
                            iconName: 'password',
                            hintText: '000 000',
                            hasCustomIcon: true,
                            customIcon: Icons.phone,
                            hasDropdown: true,
                            minWidth: 27,
                            flagUrl:
                                "https://country-code-au6g.vercel.app/${selectedCountry.image}",
                            onDropdown: () async {
                              getCountries();
                              phoneTextController.text =
                                  '${selectedCountry.dialCode} ';
                              CustomBottomSheet.showBottomSheet(
                                context,
                                Consumer<CountryProvider>(
                                  builder: (context, countryProvider, _) {
                                    if (countryProvider.isLoading) {
                                      return Padding(
                                        padding: EdgeInsets.all(15.sp),
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      );
                                    } else {
                                      return Expanded(
                                        child: ListView.builder(
                                          itemCount:
                                              countryProvider.countries.length,
                                          itemBuilder: (context, index) {
                                            final country = countryProvider
                                                .countries[index];
                                            return Material(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    selectedCountry = country;
                                                  });
                                                },
                                                splashColor: Colors.white10,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 15.sp,
                                                    vertical: 10.sp,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
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
                                                            style: TextStyle(
                                                                fontSize:
                                                                    12.sp),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(country.dialCode)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
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
                            iconName: 'password',
                            hintText: 'Address',
                            hasCustomIcon: true,
                            customIcon: Icons.location_on_rounded,
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.w),
              child: AuthButton(
                text: 'Continue',
                isDisabled: currentPage == 0 && selectedProfileInterests.isEmpty
                    ? true
                    : currentPage == 1 && gender.isEmpty
                        ? true
                        : false,
                function: () {
                  nextPage();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
