import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.hasCustomIcon = false,
      this.customIcon = Icons.person,
      required this.controller,
      this.isPassword = false,
      required this.focusNode,
      required this.hintText,
      required this.iconName,
      this.hasDropdown = false,
      this.onDropdown,
      this.minWidth = 15,
      this.flagUrl = "https://country-code-au6g.vercel.app/US.svg"});

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final FocusNode focusNode;
  final bool isPassword;
  final String hintText;
  final String iconName;
  final bool hasCustomIcon;
  final IconData customIcon;
  final bool hasDropdown;
  final Function()? onDropdown;
  final double minWidth;
  final String flagUrl;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = true;

  bool _hasFocus = false;

  void checkFocus() => setState(
      () => widget.focusNode.hasFocus ? _hasFocus = true : _hasFocus = false);

  void toggleIsObscure() => setState(() => isObscure = !isObscure);

  @override
  void initState() {
    super.initState();

    widget.focusNode.addListener(checkFocus);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(
        color: const Color(0xFF2C2C2C),
        width: 1.sp,
      ),
    );

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      keyboardType: widget.textInputType,
      style: textTheme.bodyMedium,
      cursorColor: theme.primaryColor,
      obscureText: widget.isPassword ? isObscure : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: _hasFocus
            ? theme.primaryColor.withOpacity(0.1)
            : const Color(0xFF222222),
        hintText: widget.hintText,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: Colors.white54,
        ),
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder.copyWith(
          borderSide: BorderSide(
            color: theme.primaryColor,
            width: 1.sp,
          ),
        ),
        errorBorder: outlineInputBorder.copyWith(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.sp,
          ),
        ),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: widget.hasCustomIcon
                  ? Icon(
                      widget.customIcon,
                      color: HexColor("#9CBB30"),
                    )
                  : IconButton(
                      onPressed: null,
                      icon: SvgPicture.asset(
                          'assets/icons/${widget.iconName}.svg'),
                    ),
            ),
            widget.hasDropdown
                ? SizedBox(
                    width: 10.sp,
                  )
                : const SizedBox(
                    width: 0,
                  ),
            widget.hasDropdown
                ? GestureDetector(
                    onTap: widget.onDropdown,
                    child: Row(
                      children: [
                        SvgPicture.network(
                          widget.flagUrl,
                          width: 17.sp,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.white,
                          size: 13.sp,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(
                    width: 0,
                  )
          ],
        ),
        prefixIconConstraints: BoxConstraints(minWidth: widget.minWidth.w),
        contentPadding: EdgeInsets.only(
          left: 5.w,
          top: 2.5.h,
          bottom: 2.5.h,
        ),
        suffixIconColor: Colors.white,
        suffixIconConstraints: BoxConstraints(minWidth: 12.w),
        suffixIcon: Visibility(
          visible: widget.isPassword,
          child: Container(
            margin: EdgeInsets.only(right: 5.sp),
            child: IconButton(
              onPressed: toggleIsObscure,
              icon: Icon(
                isObscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
