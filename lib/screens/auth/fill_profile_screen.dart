import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/country.dart';
import '../../models/gender.dart';
import '../../widgets/auth_widgets/auth_button.dart';
import 'profile_setup_steps/step_1.dart';
import 'profile_setup_steps/step_2.dart';
import 'profile_setup_steps/step_3.dart';
import 'profile_setup_steps/step_4.dart';

class FillProfileScreen extends StatefulWidget {
  static const routeName = '/FillProfileScreen';
  const FillProfileScreen({super.key});

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  final pageViewController = PageController();

  int currentPage = 0;
  List<String> selectedProfileInterests = [];
  Gender gender = Gender.others;
  DateTime dateOfBirth = DateTime.now();
  File? file;

  String fullName = '';
  String username = '';
  String email = '';
  String phoneNumber = '';
  String address = '';

  Country selectedCountry = const Country(
    code: "US",
    name: "name",
    image: "US.svg",
    dialCode: "+1",
  );

  bool inputsStatus = false;

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

  @override
  void dispose() {
    super.dispose();

    pageViewController.dispose();
  }

  void getProfileInterests(List<String> profileInterest) =>
      setState(() => selectedProfileInterests = profileInterest);

  void getGender(Gender selectedGender) =>
      setState(() => gender = selectedGender);

  void getDateOfBirth(DateTime selectedDOB) =>
      setState(() => dateOfBirth = selectedDOB);

  void getInputStatus(bool status) => setState(() => inputsStatus = status);
  void getImageFile(File? imageFile) => setState(() => file = imageFile);
  void getFullName(String fName) => setState(() => fullName = fName);
  void getUsername(String uName) => setState(() => username = uName);
  void getEmail(String eMail) => setState(() => email = eMail);
  void getPhoneNumber(String number) => setState(() => phoneNumber = number);
  void getAddress(String uAddress) => setState(() => address = uAddress);
  void getCountryCode(Country newCountry) =>
      setState(() => selectedCountry = newCountry);

  @override
  Widget build(BuildContext context) {
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
                  Step1(getProfileInterests: getProfileInterests),
                  Step2(
                    goBack: goBack,
                    gender: gender,
                    getGender: getGender,
                  ),
                  Step3(
                    goBack: goBack,
                    dateOfBirth: dateOfBirth,
                    getDateOfBirth: getDateOfBirth,
                  ),
                  Step4(
                    goBack: goBack,
                    getInputsStatus: getInputStatus,
                    getFullName: getFullName,
                    getUsername: getUsername,
                    getEmail: getEmail,
                    getPhoneNumber: getPhoneNumber,
                    getAddress: getAddress,
                    getSelectedCountry: getCountryCode,
                    currentCountry: selectedCountry,
                    getImageFile: getImageFile,
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
                    : currentPage == 1 && gender == Gender.others
                        ? true
                        : currentPage == 3 && inputsStatus
                            ? true
                            : false,
                function: () {
                  if (currentPage == 3) {
                    return;
                  }
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
