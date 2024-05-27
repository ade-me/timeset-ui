import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timeset/models/post.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/feeds_screen_widgets/feed_options.dart';

class SingleFeed extends StatefulWidget {
  const SingleFeed({
    super.key,
    required this.post,
    required this.isInView,
  });

  final Post post;
  final bool isInView;

  @override
  State<SingleFeed> createState() => _SingleFeedState();
}

class _SingleFeedState extends State<SingleFeed> {
  final CarouselController carouselController = CarouselController();
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  int currentIndex = 0;

  Future<void> initializeVideo() async {
    videoPlayerController = VideoPlayerController.network(
      widget.post.content[0].uri,
    );

    await videoPlayerController!.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      looping: true,
      aspectRatio: 9 / 16,
      autoInitialize: true,
      showOptions: false,
      showControls: false,
    );

    if (widget.isInView) {
      await videoPlayerController!.play();
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.post.content.length == 1 &&
        widget.post.content[0].type == "video") {
      initializeVideo();
    }

    widget.isInView
        ? videoPlayerController?.play()
        : videoPlayerController?.pause();

    widget.isInView
        ? chewieController?.videoPlayerController.play()
        : chewieController?.videoPlayerController.pause();

    videoPlayerController?.addListener(() {
      if (widget.isInView) {
        if (!videoPlayerController!.value.isPlaying) {
          videoPlayerController!.play();
        }
      } else {
        if (videoPlayerController!.value.isPlaying) {
          videoPlayerController!.pause();
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant SingleFeed oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isInView != oldWidget.isInView) {
      if (widget.isInView) {
        videoPlayerController?.play();
      } else {
        videoPlayerController?.pause();
      }
    }
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.white10,
            width: 0.5,
          ),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          widget.post.content.length != 1
              ? CarouselSlider(
                  items: widget.post.content
                      .map(
                        (item) => item.type == "image"
                            ? Image.network(
                                item.uri,
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
                )
              : widget.post.content[0].type == "image"
                  ? Image.network(
                      'https://images.pexels.com/photos/13914818/pexels-photo-13914818.jpeg?auto=compress&cs=tinysrgb&w=600',
                      height: 100.h,
                      width: 100.w,
                      fit: BoxFit.contain,
                    )
                  : chewieController == null
                      ? const SizedBox()
                      : Container(
                          alignment: Alignment.center,
                          child: AspectRatio(
                            aspectRatio: 9 / 16,
                            child: Chewie(
                              controller: chewieController!,
                            ),
                          ),
                        ),
          Positioned(
            bottom: 22.h,
            child: Visibility(
              visible: widget.post.content.length > 1,
              child: AnimatedSmoothIndicator(
                activeIndex: currentIndex,
                count: widget.post.content.length,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: HexColor("#ffffff"),
                  dotColor: const Color.fromRGBO(255, 255, 255, 0.3),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 5,
            child: FeedOptions(),
          ),
        ],
      ),
    );
  }
}
