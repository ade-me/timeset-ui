import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/general_app_padding.dart';
import '../../widgets/inbox_widgets/call_dialog.dart';

class CallScreen extends StatefulWidget {
  static const routeName = '/CallScreen';

  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  CallType callType = CallType.audio;

  Timer? _timer;

  Duration _duration = const Duration(
    seconds: 0,
  );

  bool isStarted = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        callType = ModalRoute.of(context)!.settings.arguments as CallType;
      });
    });

    Future.delayed(const Duration(seconds: 5), startTimer);

    super.initState();
  }

  void startTimer() {
    setState(() {
      isStarted = true;
    });

    _timer = Timer.periodic(
        const Duration(
          seconds: 1,
        ), (timer) {
      setState(() {
        _duration = _duration + const Duration(seconds: 1);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _timer?.cancel();
  }

  String formatDuration() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(_duration.inHours.remainder(24));
    String minutes = twoDigits(_duration.inMinutes.remainder(60));
    String seconds = twoDigits(_duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    bool isVideo = callType == CallType.video;

    return Scaffold(
      body: SafeArea(
        child: GeneralAppPadding(
          child: Column(
            children: [
              const AppBarWithBackButton(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50.sp,
                      backgroundColor: AppColors.primary,
                      backgroundImage: const NetworkImage(
                        'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=600',
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Lewis Drew',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 25.sp),
                    ),
                    SizedBox(height: 1.h),
                    Visibility(
                      visible: isStarted,
                      replacement: const Text('Calling...'),
                      child: Text(
                        formatDuration(),
                        style: const TextStyle(letterSpacing: 5),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20.sp,
                    backgroundColor: Colors.white10,
                    foregroundColor: Colors.white70,
                    child: const Icon(
                      Icons.mic_off_rounded,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: CircleAvatar(
                      radius: 28.sp,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: Icon(
                        !isVideo ? Icons.call_rounded : Icons.videocam,
                        size: 28.sp,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isVideo,
                    child: CircleAvatar(
                      radius: 20.sp,
                      backgroundColor: Colors.white10,
                      foregroundColor: Colors.white70,
                      child: const Icon(
                        Icons.videocam_off_rounded,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }
}
