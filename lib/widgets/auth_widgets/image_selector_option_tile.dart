import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../services/file_picker.dart';

class ImageSelectorOptionTIle extends StatelessWidget {
  const ImageSelectorOptionTIle({
    super.key,
    required this.label,
    required this.icon,
    required this.imageSource,
    required this.getImageFile,
  });

  final String label;
  final IconData icon;
  final ImageSource imageSource;
  final Function(File?) getImageFile;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        File? file = await FilePicker.getPhoto(imageSource: imageSource);

        getImageFile(file);
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: HexColor("#9CBB30"),
          ),
          SizedBox(
            width: 10.sp,
          ),
          Text(label),
        ],
      ),
    );
  }
}
