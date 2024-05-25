import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:timeset/models/content.dart';

class FirebaseStorageUploader {
  static Future<String?> uploadProfileImage(File imageFile) async {
    try {
      FirebaseStorage storageInstance = FirebaseStorage.instance;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      String path = "uploads/${imageFile.path.split("/").last}.$fileName";
      Reference storageRef = storageInstance.ref().child(path);

      UploadTask uploadTask = storageRef.putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;

      String imageUrl = await snapshot.ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      print("Faild to upload image error: $e");
      return null;
    }
  }

  static Future<List<Content>> uploadFiles(List<File> files) async {
    List<Content> uploadedFiles = [];

    for (File file in files) {
      // String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      String fileType = _getFileType(file);

      String? downloadURL = await uploadProfileImage(file);
      uploadedFiles
          .add(Content(uri: "$downloadURL", type: fileType, effect: "none"));
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
