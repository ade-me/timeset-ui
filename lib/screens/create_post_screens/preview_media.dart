import 'dart:io';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timeset/helpers/get_file_type.dart';
import 'package:timeset/widgets/auth_widgets/auth_button.dart';
import 'package:video_player/video_player.dart';

class PreviewMedia extends StatefulWidget {
  const PreviewMedia({
    super.key,
    required this.files,
    required this.pageController,
  });
  final List<File> files;
  final PageController pageController;

  @override
  State<PreviewMedia> createState() => _PreviewMediaState();
}

class _PreviewMediaState extends State<PreviewMedia> {
  final CarouselController carouselController = CarouselController();
  VideoPlayerController? videoPlayerController;
  final List<VideoPlayerController> _videoControllers = [];
  ChewieController? chewieController;

  int currentIndex = 0;

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      currentIndex = index;
    });
    if (getFileType(widget.files[index]) == "video") {
      _initializeChewieController(index);
    } else {
      _videoControllers.forEach((controller) async {
        await controller.pause();
      });
    }
  }

  void _initializeVideoControllers() {
    for (var file in widget.files) {
      _videoControllers.add(VideoPlayerController.file(file));
    }
    _videoControllers.forEach((controller) async {
      await controller.initialize();
    });

    if (getFileType(widget.files[0]) == "video") {
      // _initializeChewieController(currentIndex);
    }
  }

  Future<void> _initializeChewieController(int index) async {
    chewieController?.dispose();
    chewieController = ChewieController(
      videoPlayerController: _videoControllers[index],
      looping: true,
      aspectRatio: 9 / 16,
      autoInitialize: true,
      showOptions: false,
      showControls: false,
    );

    if (mounted) {
      setState(() {});
    }
    if (currentIndex == index) {
      _videoControllers[index].play();
      chewieController!.videoPlayerController.play();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.files.where((file) => getFileType(file) == "video").isNotEmpty) {
      _initializeVideoControllers();
    }
  }

  @override
  void dispose() {
    for (var controller in _videoControllers) {
      controller.dispose();
    }
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        widget.pageController.previousPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutCirc,
        );
      },
      child: Scaffold(
        body: SizedBox(
          width: 100.w,
          child: Stack(
            children: [
              CarouselSlider(
                items: widget.files
                    .map(
                      (item) => getFileType(item) == "image"
                          ? Image.file(
                              item,
                              fit: BoxFit.contain,
                              width: 100.w,
                            )
                          : chewieController == null
                              ? const SizedBox()
                              : AspectRatio(
                                  aspectRatio: 9 / 16,
                                  child: Chewie(
                                    controller: chewieController!,
                                  ),
                                ),
                    )
                    .toList(),
                carouselController: carouselController,
                options: CarouselOptions(
                  height: 100.h,
                  aspectRatio: 9 / 16,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  enlargeFactor: 0,
                  onPageChanged: onPageChange,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Positioned(
                bottom: 22.h,
                child: Visibility(
                  visible: widget.files.length > 1,
                  child: Container(
                    alignment: Alignment.center,
                    width: 100.w,
                    child: AnimatedSmoothIndicator(
                      activeIndex: currentIndex,
                      count: widget.files.length,
                      effect: WormEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: HexColor("#ffffff"),
                        dotColor: const Color.fromRGBO(255, 255, 255, 0.3),
                      ),
                    ),
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
                            widget.pageController.previousPage(
                              duration: const Duration(
                                milliseconds: 400,
                              ),
                              curve: Curves.easeInOutCirc,
                            );
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
                                borderRadius: BorderRadius.circular(20),
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
                        SizedBox(
                          width: 30.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 3.h,
                width: 100.w,
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Row(
                    children: [
                      Expanded(
                        child: AuthButton(
                          text: "Post to Story",
                          function: () {},
                          color: "#ffffff",
                          bgColor: "#141414",
                          grayButton: true,
                        ),
                      ),
                      SizedBox(
                        width: 5.sp,
                      ),
                      Expanded(
                        child: AuthButton(
                          text: "Next",
                          function: () {
                            widget.pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOutCirc,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
