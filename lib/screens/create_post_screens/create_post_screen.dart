import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeset/bloc/camera_bloc.dart';
import 'package:timeset/screens/create_post_screens/custom_camera.dart';
import 'package:timeset/services/firebase_storage_uploader.dart';
import 'package:timeset/utils/camera_utils.dart';
import 'package:timeset/utils/permission_utils.dart';

import '../../screens/create_post_screens/addlocation_screen.dart';
import '../../screens/create_post_screens/addshopping_items_screen.dart';
import '../../screens/create_post_screens/camera_screen.dart';
import '../../screens/create_post_screens/post_screen.dart';
import '../../screens/create_post_screens/tagpeople_screen.dart';

class CreatePostScreen extends StatefulWidget {
  static const routeName = '/CreatePostScreen';
  const CreatePostScreen({super.key, required this.cameras});
  final List<CameraDescription> cameras;

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final pageController = PageController();
  int currentIndex = 0;
  List<File> files = [];

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCirc,
    );
  }

  Future<void> _uploadFiles() async {
    try {
      print(files);
      List<Map<String, String>> uploadedFiles =
          await FirebaseStorageUploader.uploadFiles(files);
      print(uploadedFiles);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      // BlocProvider(
      //   create: (context) {
      //     return CameraBloc(
      //       cameraUtils: CameraUtils(),
      //       permissionUtils: PermissionUtils(),
      //     )..add(const CameraInitialize(recordingLimit: 15));
      //   },
      //   child: CameraScreen(
      //     pageController: pageController,
      //   ),
      // ),
      CustomCameraScreen(
        pageController: pageController,
        cameras: widget.cameras,
        onPictureTaken: (path) {
          files.add(File(path));
          setState(() {});
        },
        onFilesSelected: (files) {
          print(files);
        },
      ),
      PostScreen(
        pageController: pageController,
        onPostClicked: () {
          _uploadFiles();
        },
      ),
      TagpeopleScreen(pageController: pageController),
      AddlocationScreen(pageController: pageController),
      AddshoppingItemsScreen(pageController: pageController),
    ];
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: pages,
        onPageChanged: (index) => setState(() {
          currentIndex = index;
        }),
      ),
    );
  }
}
