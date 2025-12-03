import 'package:flutter/material.dart';
import 'package:news_application/core/utils/routes/app_routes.dart';
import 'package:news_application/core/utils/theme/app_colors.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  late double scaleValue;
  @override
  void initState() {
    super.initState();
    scaleValue = 0.0;
    _controller = VideoPlayerController.asset("assets/videos/splash_video.mp4")
      ..initialize().then((value) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {
          scaleValue = 1.5;
        });
      });

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(AppRoutes.homeRoute);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          AnimatedScale(
            duration: Duration(seconds: 2),
            scale: scaleValue,
            child: Text(
              "News App",
              style: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(color: AppColors.primary),
            ),
          ),
          const SizedBox(height: 50),
          CircularProgressIndicator.adaptive(),
        ],
      ),
    );
  }
}
