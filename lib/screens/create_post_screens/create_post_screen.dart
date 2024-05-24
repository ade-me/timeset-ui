import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeset/helpers/custom_scaffold_messenger.dart';
import 'package:timeset/models/content.dart';
import 'package:timeset/screens/create_post_screens/custom_camera.dart';
import 'package:timeset/services/firebase_storage_uploader.dart';
import 'package:timeset/state_management/post_provider.dart';

import '../../screens/create_post_screens/addlocation_screen.dart';
import '../../screens/create_post_screens/addshopping_items_screen.dart';
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
  final textController = TextEditingController();
  int currentIndex = 0;
  List<File> files = [];
  List<Content> content = [];
  Map<String, dynamic>? selectedLocation;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCirc,
    );
  }

  Future<void> _uploadFiles() async {
    try {
      List<Content> uploadedFiles =
          await FirebaseStorageUploader.uploadFiles(files);
      setState(() {
        content = uploadedFiles;
      });
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
    textController.dispose();
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
        onFilesSelected: (filesAdded) {
          files = [...files, ...filesAdded!];
          setState(() {});
        },
      ),
      PostScreen(
        pageController: pageController,
        captionFieldController: textController,
        onPostClicked: () {
          createPost();
        },
        location: selectedLocation != null
            ? selectedLocation!["description"]
            : "Add Location",
      ),
      TagpeopleScreen(
        pageController: pageController,
      ),
      AddlocationScreen(
        pageController: pageController,
        onLocationSelected: (value) {
          selectedLocation = value;
          setState(() {});
        },
      ),
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

  void createPost() async {
    try {
      if (textController.text.isEmpty) {
        showScaffoldMessenger(
          scaffoldKey: _scaffoldKey,
          textContent: 'Please enter caption to continue',
          context: context,
          bkgColor: Colors.red,
        );
      } else if (selectedLocation == null) {
        showScaffoldMessenger(
          scaffoldKey: _scaffoldKey,
          textContent: 'Please select a location to continue',
          context: context,
          bkgColor: Colors.red,
        );
      } else {
        var postProvider = Provider.of<PostProvider>(context, listen: false);

        await postProvider.createPost(
          title: textController.text,
          description: "",
          files: files,
          allowComment: true,
          people: [""],
          product: [""],
          location: selectedLocation!["longLat"],
          context: context,
          scaffoldKey: _scaffoldKey,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
