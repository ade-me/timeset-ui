import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    required this.controller,
    this.isPassword = false,
    required this.focusNode,
    required this.hintText,
    required this.iconName,
  });

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final FocusNode focusNode;
  final bool isPassword;
  final String hintText;
  final String iconName;

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
      obscureText: isObscure,
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
        prefixIcon: IconButton(
          onPressed: null,
          icon: SvgPicture.asset('assets/icons/${widget.iconName}.svg'),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 15.w),
        contentPadding: EdgeInsets.only(
          left: 5.w,
          top: 2.5.h,
          bottom: 2.5.h,
        ),
        suffixIconColor: Colors.white,
        suffixIcon: Visibility(
          visible: widget.isPassword,
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
    );
  }
}
