import 'dart:io';

String getFileType(File file) {
  String extension = file.path.split('.').last;
  if (extension == 'mp4' || extension == 'mov' || extension == 'avi') {
    return 'video';
  } else if (extension == 'jpg' || extension == 'jpeg' || extension == 'png') {
    return 'image';
  } else {
    return 'other';
  }
}
