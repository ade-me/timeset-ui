import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class SearchHistoryTile extends StatefulWidget {
  const SearchHistoryTile(
      {super.key, required this.text, this.onTap, this.onRemove});

  final String text;
  final Function()? onTap;
  final Function()? onRemove;

  @override
  State<SearchHistoryTile> createState() => _SearchHistoryTileState();
}

class _SearchHistoryTileState extends State<SearchHistoryTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
        contentPadding: const EdgeInsets.all(0),
        minVerticalPadding: 0,
        title: Text(
          widget.text,
          style: TextStyle(
            color: HexColor("#ffffff"),
            fontSize: 11.sp,
          ),
        ),
        trailing: GestureDetector(
          onTap: widget.onRemove,
          child: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
