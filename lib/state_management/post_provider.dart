// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:timeset/models/content.dart';
import 'package:timeset/repositories/post_repo.dart';
import 'package:timeset/screens/home_screen.dart';
import 'package:timeset/services/firebase_storage_uploader.dart';

import '../helpers/custom_scaffold_messenger.dart';
import '../helpers/show_custom_loader.dart';

class PostProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _changeLoadingState(bool status) {
    _isLoading = status;

    notifyListeners();
  }

  Future<void> createPost({
    required String title,
    required String description,
    required List<File> files,
    required List<String> people,
    required List<String> product,
    required List<String> location,
    required bool allowComment,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      _changeLoadingState(true);
      showCustomLoader(context);

      List<Content> uploadedFiles =
          await FirebaseStorageUploader.uploadFiles(files);

      List<Map<String, dynamic>> contentJsonList =
          uploadedFiles.map((content) => content.toJson()).toList();

      Response response = await PostRepo.createPost(
        title: title,
        description: description,
        content: contentJsonList,
        people: people,
        product: product,
        location: location,
        allowComment: allowComment,
      );

      dynamic body = jsonDecode(response.body);
      int statusCode = response.statusCode;

      if (statusCode == 201) {
        if (context.mounted) {
          _changeLoadingState(false);
          showScaffoldMessenger(
            scaffoldKey: scaffoldKey,
            textContent: 'Post created successfully',
            context: context,
            bkgColor: Colors.green,
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            ModalRoute.withName(HomeScreen.routeName),
          );
        }

        _changeLoadingState(false);
      } else {
        // List<dynamic> message = body['message'] as List<dynamic>;

        print('Error logging user in: ${body['message']}');
        _changeLoadingState(false);
        if (context.mounted) {
          showScaffoldMessenger(
            scaffoldKey: scaffoldKey,
            textContent: body['message'].toString(),
            context: context,
          );

          Navigator.pop(context);
        }
      }
    } catch (e) {
      print('Error logging user in: $e');
      _changeLoadingState(false);
      if (context.mounted) {
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: 'An error occured, please try again.',
          context: context,
        );

        Navigator.pop(context);
      }
    }
  }
}
