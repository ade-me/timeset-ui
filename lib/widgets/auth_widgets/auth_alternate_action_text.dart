import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AuthAlternateActionText extends StatelessWidget {
  const AuthAlternateActionText({
    super.key,
    required this.alternateText,
    required this.actionText,
    this.function,
  });

  final String alternateText;
  final String actionText;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          alternateText,
        ),
        GestureDetector(
          onTap: function,
          child: Text(
            actionText,
            style: TextStyle(
              color: HexColor(
                "#9CBB30",
              ),
            ),
          ),
        )
      ],
    );
  }
}
