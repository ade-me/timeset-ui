import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:timeset/constants/app_colors.dart';
import 'package:timeset/helpers/custom_scaffold_messenger.dart';
import 'package:timeset/helpers/formatter.dart';
import 'package:timeset/helpers/get_file_type.dart';
import 'package:timeset/services/file_picker.dart';
import 'package:timeset/widgets/create_post_widgets/cam_mode.dart';

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

  final carouselController = CarouselController();

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  bool showFocusCircle = false;
  double x = 0;
  double y = 0;
  String mode = "photo";
  int camMode = 0;
  bool isFlashOn = false;
  double currentZoom = 1.0;
  double baseScale = 1.0;
  bool isRecording = false;
  int currentIndex = 0;
  Timer? _timer;
  int _start = 15;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            stopRecording();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      currentIndex = index;
    });
    if (isRecording) {
      stopRecording();
    }
  }

  void switchCamera() async {
    int newCameraIndex = camMode == 0 ? 1 : 0;

    _controller = CameraController(
        widget.cameras[newCameraIndex], ResolutionPreset.medium);

    _initializeControllerFuture = _controller.initialize();

    if (mounted) {
      setState(() {
        camMode = newCameraIndex;
        baseScale = 1.0;
        currentZoom = 1.0;
      });
    }
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

  void startRecording() async {
    await _initializeControllerFuture;
    setState(() {
      isRecording = true;
    });
    await _controller.startVideoRecording();
    startTimer();
  }

  void stopRecording() async {
    try {
      final image = await _controller.stopVideoRecording();
      setState(() {
        isRecording = false;
      });
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

    if (files != null) {
      List<File> selectedFiles =
          files.where((file) => getFileType(file) != "other").toList();

      if (selectedFiles.isNotEmpty) {
        widget.onFilesSelected!(
          files.where((file) => getFileType(file) != "other").toList(),
        );
        widget.pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutCirc,
        );
      } else {
        if (context.mounted) {
          showScaffoldMessenger(
            scaffoldKey: _scaffoldKey,
            textContent: 'Select videos or images to continue',
            context: context,
            bkgColor: Colors.red,
          );
        }
      }
    }
  }

  void toggleFlash() async {
    if (isFlashOn) {
      await _controller.setFlashMode(FlashMode.off);
    } else {
      await _controller.setFlashMode(FlashMode.torch);
    }
    if (mounted) {
      setState(() {
        isFlashOn = !isFlashOn;
      });
    }
  }

  void onScaleStart(ScaleStartDetails details) {
    baseScale = currentZoom;
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    final double scale = details.scale;
    if (mounted) {
      setState(() {
        currentZoom = (baseScale * scale).clamp(1.0, 4.0);
        _controller.setZoomLevel(currentZoom);
      });
    }
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
    super.dispose();
    _controller.dispose();
    _timer?.cancel();
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
              child: Column(
                children: [
                  Expanded(
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
                        if (showFocusCircle)
                          Positioned(
                            top: y - 20,
                            left: x - 20,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 1.5),
                              ),
                            ),
                          ),
                        Visibility(
                          visible: isRecording,
                          child: Positioned(
                            top: 110,
                            width: 100.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.red,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.sp,
                                    vertical: 5.sp,
                                  ),
                                  child: Text(
                                    "Recording ${formatHHMMSS(_start)}",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !isRecording,
                          child: CarouselSlider(
                              carouselController: carouselController,
                              options: CarouselOptions(
                                onPageChanged: onPageChange,
                                height: 100.h,
                                viewportFraction: 0.24,
                                enableInfiniteScroll: false,
                              ),
                              items: [
                                CamMode(
                                  text: "Photo",
                                  icon: Icons.camera_alt_rounded,
                                  isSelected: currentIndex == 0,
                                  onTap: () {
                                    // print("photo");
                                    carouselController.nextPage();
                                  },
                                ),
                                CamMode(
                                  text: "Video",
                                  icon: Icons.videocam_rounded,
                                  isSelected: currentIndex == 1,
                                  onTap: () {
                                    // print("video");
                                    carouselController.previousPage();
                                  },
                                ),
                              ]),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: SafeArea(
                            child: Container(
                              width: 100.w,
                              padding: EdgeInsets.all(10.sp),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 5,
                                        sigmaY: 5,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.black.withOpacity(
                                            0.2,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp,
                                          vertical: 5.sp,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.music_note_rounded,
                                              color: Colors.white,
                                              size: 13.sp,
                                            ),
                                            SizedBox(
                                              width: 4.sp,
                                            ),
                                            Text(
                                              "Add Sound",
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
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
                                      Icons.image_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if (!isRecording && currentIndex == 0) {
                                          takePicture();
                                        }
                                      },
                                      onLongPress: () async {
                                        if (currentIndex == 1 && !isRecording) {
                                          startRecording();
                                        }
                                      },
                                      onLongPressUp: () async {
                                        if (currentIndex == 1 && isRecording) {
                                          stopRecording();
                                        }
                                      },
                                      child: Transform.scale(
                                        scale: isRecording ? 1.2 : 1,
                                        child: CircleAvatar(
                                          backgroundColor: isRecording
                                              ? AppColors.primary
                                                  .withOpacity(0.5)
                                              : AppColors.primary,
                                          radius: 40,
                                          child: Icon(
                                            currentIndex == 0
                                                ? Icons.camera_alt_rounded
                                                : isRecording
                                                    ? Icons.stop_rounded
                                                    : Icons.videocam_rounded,
                                            size: 35,
                                            color: currentIndex == 0
                                                ? Colors.transparent
                                                : HexColor("#141414"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                      ],
                    ),
                  ),
                  Container(
                    color: HexColor("#212121"),
                    padding: EdgeInsets.all(15.sp),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Camera"),
                        SizedBox(
                          width: 10.w,
                        ),
                        const Text("Quick"),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            // Otherwise, display a loading indicator.
            return Center(
                child: CircularProgressIndicator(
              color: AppColors.primary,
            ));
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

      double fullWidth = MediaQuery.of(context).size.width;
      double cameraHeight = fullWidth * _controller.value.aspectRatio;

      double xp = x / fullWidth;
      double yp = y / cameraHeight;

      Offset point = Offset(xp, yp);

      // Manually focus
      if ((point.dx < 0 || point.dx > 1 || point.dy < 0 || point.dy > 1)) {
      } else {
        await _controller.setFocusPoint(point);
        // Manually set light exposure
        _controller.setExposurePoint(point);
        if (mounted) {
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
  }
}
