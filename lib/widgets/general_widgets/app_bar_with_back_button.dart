import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'custom_app_bar_icon.dart';

class AppBarWithBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60.0);
  final String title;
  final Function? function;
  final bool hasCustomFunction;
  final List<Widget>? actions;
  final bool centerTitle;

  const AppBarWithBackButton({
    super.key,
    this.title = "",
    this.function,
    this.hasCustomFunction = false,
    this.actions,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // back button
          Row(
            children: [
              CustomAppBarIcon(
                icon: 'back',
                function: () => hasCustomFunction
                    ? function!()
                    : Navigator.of(context).pop(),
              ),
              SizedBox(
                width: 15.sp,
              ),
              titleWidget(
                visible: !centerTitle,
              ),
              const Spacer(),
              Row(
                children: actions ?? [],
              ),
            ],
          ),
          titleWidget(visible: centerTitle),
        ],
      ),
    );
  }

  Visibility titleWidget({
    required bool visible,
  }) {
    return Visibility(
      visible: visible,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
