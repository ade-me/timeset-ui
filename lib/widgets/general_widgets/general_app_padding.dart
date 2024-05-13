import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class GeneralAppPadding extends StatelessWidget {
  const GeneralAppPadding({
    super.key,
    required this.child,
    this.verticalPadding = 0,
  });

  final Widget child;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: verticalPadding,
      ),
      child: child,
    );
  }
}
