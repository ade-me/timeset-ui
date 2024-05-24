import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/constants/app_colors.dart';
import 'package:timeset/services/file_picker.dart';

class CustomCameraScreen extends StatefulWidget {
  const CustomCameraScreen({
    super.key,
    required this.cameras,
    this.onPictureTaken,
    this.onFilesSelected,
    required this.pageController,
  });

  final List<CameraDescription> cameras;
  final Function(String)? onPictureTaken;
  final Function(List<File>?)? onFilesSelected;
  final PageController pageController;

  @override
  CustomCameraScreenState createState() => CustomCameraScreenState();
}

class CustomCameraScreenState extends State<CustomCameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  bool showFocusCircle = false;
  double x = 0;
  double y = 0;
  String mode = "photo";
  int camMode = 0;
  bool isFlashOn = false;
  double currentZoom = 1.0;
  double baseScale = 1.0;

  void switchCamera() async {
    int newCameraIndex = camMode == 0 ? 1 : 0;

    _controller = CameraController(
        widget.cameras[newCameraIndex], ResolutionPreset.medium);

    _initializeControllerFuture = _controller.initialize();

    setState(() {
      camMode = newCameraIndex;
      baseScale = 1.0;
      currentZoom = 1.0;
    });
  }

  void takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      if (!context.mounted) return;

      widget.onPictureTaken!(image.path);
      widget.pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCirc,
      );
    } catch (e) {
      print(e);
    }
  }

  void uploadMedias() async {
    List<File>? files = await FilePicker.getMultipleFiles();

    widget.onFilesSelected!(files);
    widget.pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCirc,
    );
  }

  void toggleFlash() async {
    if (isFlashOn) {
      await _controller.setFlashMode(FlashMode.off);
    } else {
      await _controller.setFlashMode(FlashMode.torch);
    }
    setState(() {
      isFlashOn = !isFlashOn;
    });
  }

  void onScaleStart(ScaleStartDetails details) {
    baseScale = currentZoom;
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    final double scale = details.scale;
    setState(() {
      currentZoom = (baseScale * scale).clamp(1.0, 4.0);
    });
    _controller.setZoomLevel(currentZoom);
  }

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameras.first,
      ResolutionPreset.max,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onScaleStart: onScaleStart,
              onScaleUpdate: onScaleUpdate,
              onTapUp: (details) {
                _onTap(details);
              },
              child: Stack(
                children: [
                  Center(
                    child: Transform.scale(
                      scale: 1 /
                          (_controller.value.aspectRatio *
                              MediaQuery.of(context).size.aspectRatio),
                      child: CameraPreview(_controller),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    child: SizedBox(
                      width: 100.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 25,
                            child: IconButton(
                              onPressed: () async {
                                uploadMedias();
                              },
                              icon: const Icon(
                                Icons.art_track_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: AppColors.primary,
                            radius: 40,
                            child: IconButton(
                              onPressed: () async {
                                takePicture();
                              },
                              icon: const Icon(
                                Icons.cached_rounded,
                                color: Colors.transparent,
                                size: 50,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 25,
                            child: IconButton(
                              onPressed: () async {
                                switchCamera();
                              },
                              icon: const Icon(
                                Icons.cached_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SafeArea(
                      child: Container(
                        width: 100.w,
                        padding: EdgeInsets.all(10.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.close,
                                size: 20.sp,
                              ),
                              color: Colors.white,
                            ),
                            IconButton(
                              onPressed: () {
                                toggleFlash();
                              },
                              icon: Icon(
                                isFlashOn
                                    ? Icons.flash_on_rounded
                                    : Icons.flash_off_rounded,
                                size: 20.sp,
                              ),
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (showFocusCircle)
                    Positioned(
                      top: y - 20,
                      left: x - 20,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    )
                ],
              ),
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<void> _onTap(TapUpDetails details) async {
    if (_controller.value.isInitialized) {
      showFocusCircle = true;
      x = details.localPosition.dx;
      y = details.localPosition.dy;

      print(x);
      print(y);

      double fullWidth = MediaQuery.of(context).size.width;
      double cameraHeight = fullWidth * _controller.value.aspectRatio;

      double xp = x / fullWidth;
      double yp = y / cameraHeight;

      Offset point = Offset(xp, yp);
      print("point : $point");

      // Manually focus
      await _controller.setFocusPoint(point);

      // Manually set light exposure
      _controller.setExposurePoint(point);

      setState(() {
        Future.delayed(const Duration(seconds: 2)).whenComplete(() {
          setState(() {
            showFocusCircle = false;
          });
        });
      });
    }
  }
}
