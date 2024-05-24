import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageUploader {
  FirebaseAuth authInstance = FirebaseAuth.instance;
  FirebaseStorage storageInstance = FirebaseStorage.instance;
  FirebaseFirestore cloudInstance = FirebaseFirestore.instance;

  Future<String?> uploadProfileImage(File imageFile) async {
    try {
      String? uid = authInstance.currentUser?.uid;
      if (uid == null) {
        throw Exception("User not authenticated");
      }

      String path = "users/$uid";
      Reference storageRef = storageInstance.ref().child(path);

      UploadTask uploadTask = storageRef.putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;

      String imageUrl = await snapshot.ref.getDownloadURL();

      await authInstance.currentUser?.updatePhotoURL(imageUrl);

      return imageUrl;
    } catch (e) {
      print("Profile image upload error: $e");
      return null;
    }
  }

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
