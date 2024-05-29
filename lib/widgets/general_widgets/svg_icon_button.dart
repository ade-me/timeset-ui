import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIconButton extends StatelessWidget {
  const SvgIconButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  final String icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset('assets/icons/$icon.svg'),
    );
  }
}
