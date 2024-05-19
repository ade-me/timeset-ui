import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../helpers/profile_interest_items.dart';
import '../../../widgets/auth_widgets/custom_chip.dart';
import '../../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../../widgets/general_widgets/general_app_padding.dart';

class Step1 extends StatefulWidget {
  const Step1({super.key, required this.getProfileInterests});

  final Function(List<String>) getProfileInterests;

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  List<String> profileInterests = ProfileInterestItems.items;
  List<String> selectedProfileInterests = [];

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 4.h);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return SingleChildScrollView(
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
                                : selectedProfileInterests.remove(e);
                          },
                        );
                      },
                      child: CustomChip(
                        text: e,
                        isSelected: selectedProfileInterests.contains(e),
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
