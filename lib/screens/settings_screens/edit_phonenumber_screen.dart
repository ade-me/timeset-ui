import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/country.dart';
import '../../state_management/country_provider.dart';
import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/auth_widgets/country_list_tile.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/custom_bottom_sheet.dart';
import '../../widgets/general_widgets/custom_shimmer.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/general_app_padding.dart';

class EditPhoneNumberScreen extends StatefulWidget {
  const EditPhoneNumberScreen({
    super.key,
    required this.pageController,
  });
  final PageController pageController;

  @override
  State<EditPhoneNumberScreen> createState() => _EditPhoneNumberScreenState();
}

class _EditPhoneNumberScreenState extends State<EditPhoneNumberScreen> {
  final phoneTextController = TextEditingController();

  final phoneFocusNode = FocusNode();

  Country selectedCountry = const Country(
    code: "US",
    name: "name",
    image: "US.svg",
    dialCode: "+1",
  );

  void getCountryCode(Country newCountry) =>
      setState(() => selectedCountry = newCountry);

  void getCountries() {
    Provider.of<CountryProvider>(context, listen: false).getCountryWithCodes();
  }

  @override
  void initState() {
    super.initState();
    phoneTextController.text = '${selectedCountry.dialCode} ';
  }

  @override
  void dispose() {
    super.dispose();

    phoneTextController.dispose();

    phoneFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (willPop) {
        widget.pageController.previousPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutCirc,
        );
      },
      child: SafeArea(
        child: Column(
          children: [
            GeneralAppPadding(
              verticalPadding: 3,
              child: AppBarWithBackButton(
                title: "Edit Phone number",
                hasCustomFunction: true,
                function: () {
                  widget.pageController.previousPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOutCirc,
                  );
                },
              ),
            ),
            SizedBox(
              height: 1.w,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GeneralAppPadding(
                      child: CustomTextField(
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
                            "https://country-code-au6g.vercel.app/${selectedCountry.image}",
                        onDropdown: () async {
                          getCountries();
                          phoneTextController.text =
                              '${selectedCountry.dialCode} ';
                          showCountryBottomSheet();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GeneralAppPadding(
              verticalPadding: 3.h,
              child: AuthButton(
                text: "Save",
                function: () {},
              ),
            )
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
                    getCountry: getCountryCode,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
