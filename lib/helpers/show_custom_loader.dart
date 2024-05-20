import 'dart:ui';

import 'package:flutter/material.dart';

void showCustomLoader(
  BuildContext context,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const LoaderDialog(),
  );
}

class LoaderDialog extends StatefulWidget {
  const LoaderDialog({
    super.key,
  });

  @override
  State<LoaderDialog> createState() => _LoaderDialogState();
}

class _LoaderDialogState extends State<LoaderDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 50, end: 100).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Image.asset(
            'assets/logos/logo.png',
            height: _animation.value,
            width: _animation.value,
          ),
        ),
      ),
    );
  }
}
