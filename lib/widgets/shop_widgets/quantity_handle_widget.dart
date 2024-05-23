import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class QuantityHandlerWidget extends StatefulWidget {
  const QuantityHandlerWidget({
    super.key,
    required this.quantity,
    required this.getQuantity,
  });

  final int quantity;
  final Function(int) getQuantity;

  @override
  State<QuantityHandlerWidget> createState() => _QuantityHandlerWidgetState();
}

class _QuantityHandlerWidgetState extends State<QuantityHandlerWidget> {
  int quantity = 1;

  @override
  void initState() {
    quantity = widget.quantity;

    super.initState();
  }

  void incrementQuantity() => setState(() => quantity = ++quantity);
  void decrementQuantity() =>
      setState(() => quantity > 1 ? quantity = --quantity : null);

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(width: 5.w);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: HexColor('#2C2C2C'),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Row(
        children: [
          actionIcon(
            icon: Icons.remove_rounded,
            onTap: decrementQuantity,
          ),
          sizedBox,
          Text(
            quantity.toString(),
            style: TextStyle(
              fontSize: 8.sp,
            ),
          ),
          sizedBox,
          actionIcon(
            icon: Icons.add_rounded,
            onTap: incrementQuantity,
          ),
        ],
      ),
    );
  }

  InkWell actionIcon({
    required IconData icon,
    required Function onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap();
        widget.getQuantity(quantity);
      },
      child: Icon(
        icon,
        color: Colors.white,
        size: 14.sp,
      ),
    );
  }
}
