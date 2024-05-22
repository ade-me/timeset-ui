import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CaptionTextfield extends StatefulWidget {
  const CaptionTextfield({
    super.key,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    this.onEditingComplete,
    this.onSubmitted,
    this.validator,
  });

  final String? Function(String?)? validator;
  final Function()? onEditingComplete;
  final Function(String)? onSubmitted;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final FocusNode focusNode;
  final String hintText;

  @override
  State<CaptionTextfield> createState() => _CaptionTextfieldState();
}

class _CaptionTextfieldState extends State<CaptionTextfield> {
  bool _hasFocus = false;
  void checkFocus() => setState(
      () => widget.focusNode.hasFocus ? _hasFocus = true : _hasFocus = false);

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
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(
        color: const Color(0xFF2C2C2C),
        width: 1.sp,
      ),
    );

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      maxLines: 5,
      textInputAction: widget.textInputAction,
      keyboardType: widget.textInputType,
      style: textTheme.bodyMedium,
      cursorColor: theme.primaryColor,
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
        contentPadding: EdgeInsets.all(4.w),
      ),
      validator: widget.validator,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onSubmitted,
    );
  }
}
