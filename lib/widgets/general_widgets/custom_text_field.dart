// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.hasCustomIcon = false,
    this.customIcon = Icons.person,
    required this.controller,
    this.isPassword = false,
    required this.focusNode,
    required this.hintText,
    this.iconName = '',
    this.hasDropdown = false,
    this.onDropdown,
    this.minWidth = 15,
    this.flagUrl = "https://country-code-au6g.vercel.app/US.svg",
    this.onEditingComplete,
    this.onSubmitted,
    this.iconColor = Colors.white,
    this.validator,
    this.onChanged,
  });

  final String? Function(String?)? validator;
  final Function()? onEditingComplete;
  final Function(String)? onSubmitted;
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
  final Color iconColor;
  final Function(String)? onChanged;

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
      onChanged: widget.onChanged,
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
        prefixIcon: Visibility(
          visible: widget.hasCustomIcon || widget.iconName.isNotEmpty,
          child: Row(
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
                          'assets/icons/${widget.iconName}.svg',
                          color: widget.iconColor,
                        ),
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
      validator: widget.validator,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onSubmitted,
    );
  }
}

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.onEditingComplete,
  });

  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(
        color: theme.primaryColor,
        width: 0.5.sp,
      ),
    );

    return TextField(
      controller: widget.controller,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      style: textTheme.bodyMedium,
      cursorColor: theme.primaryColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.primaryColor.withOpacity(0.1),
        hintText: 'Search for a product',
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: Colors.white54,
        ),
        prefixIcon: IconButton(
          onPressed: null,
          icon: SvgPicture.asset(
            'assets/icons/search_inactive.svg',
            color: HexColor("#9CBB30"),
          ),
        ),
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        prefixIconConstraints: BoxConstraints(minWidth: 15.w),
        contentPadding: EdgeInsets.only(
          left: 5.w,
          top: 1.8.h,
          bottom: 1.8.h,
        ),
      ),
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
    );
  }
}

class CommentTextField extends StatefulWidget {
  const CommentTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.onEditingComplete,
    required this.focusNode,
    this.onSend,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function()? onSend;

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  bool _hasFocus = false;
  bool _isEmpty = true;

  void checkFocus() => setState(
      () => widget.focusNode.hasFocus ? _hasFocus = true : _hasFocus = false);

  void checkIsEmpty() => setState(() =>
      widget.controller.text.isEmpty ? _isEmpty = true : _isEmpty = false);

  @override
  void initState() {
    super.initState();

    widget.focusNode.addListener(checkFocus);
    widget.controller.addListener(checkIsEmpty);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(
        color: const Color(0xFF2C2C2C),
        width: 0.5.sp,
      ),
    );

    return TextField(
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      style: textTheme.bodyMedium,
      cursorColor: theme.primaryColor,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        filled: true,
        fillColor: _hasFocus
            ? theme.primaryColor.withOpacity(0.1)
            : HexColor("#2C2C2C"),
        hintText: 'Add comment',
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
        suffixIcon: _isEmpty
            ? const SizedBox()
            : Container(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: widget.onSend,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/send.svg",
                    ),
                  ),
                ),
              ),
        prefixIconConstraints: BoxConstraints(minWidth: 15.w),
        contentPadding: EdgeInsets.only(
          left: 5.w,
          top: 2.5.h,
          bottom: 2.5.h,
          right: 5.w,
        ),
      ),
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
    );
  }
}
