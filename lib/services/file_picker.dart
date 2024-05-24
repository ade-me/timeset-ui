import 'dart:io';

import 'package:image_picker/image_picker.dart';

class FilePicker {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<File?> getPhoto({
    required ImageSource imageSource,
  }) async {
    XFile? xfile = await _imagePicker.pickImage(source: imageSource);

    if (xfile != null) {
      File file = File(xfile.path);

      return file;
    } else {
      return null;
    }
  }

  static Future<List<File>?> getMultipleFiles() async {
    List<XFile>? xfiles = await _imagePicker.pickMultiImage();

    if (xfiles.isNotEmpty) {
      List<File> files = xfiles.map((xfile) => File(xfile.path)).toList();

      return files;
    } else {
      return null;
    }
  }
}
