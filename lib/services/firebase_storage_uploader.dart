import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageUploader {
  static Future<List<Map<String, String>>> uploadFiles(List<File> files) async {
    List<Map<String, String>> uploadedFiles = [];

    for (File file in files) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      String fileType = _getFileType(file);

      Reference storageReference =
          FirebaseStorage.instance.ref().child('uploads/$fileName.$fileType');

      String downloadURL = await _uploadFile(file, storageReference);
      uploadedFiles.add({'uri': downloadURL, 'type': fileType});
    }
    return uploadedFiles;
  }

  static Future<String> _uploadFile(File file, Reference ref) async {
    UploadTask uploadTask = ref.putFile(file);
    String url = await uploadTask.then((res) {
      return res.ref.getDownloadURL();
    });
    return url;
  }

  static String _getFileType(File file) {
    String extension = file.path.split('.').last;
    if (extension == 'mp4' || extension == 'mov' || extension == 'avi') {
      return 'video';
    } else if (extension == 'jpg' ||
        extension == 'jpeg' ||
        extension == 'png') {
      return 'image';
    } else {
      return 'other';
    }
  }
}
