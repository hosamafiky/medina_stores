import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    super.key,
    required this.mediaUrl,
  });
  final String mediaUrl;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late final VideoPlayerController controller;

  @override
  void initState() {
    _initializeController();
    super.initState();
  }

  void _initializeController() async {
    controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.mediaUrl),
    );
    await controller.setLooping(true);
    await controller.initialize().then((_) => setState(() {}));
    await controller.play();
  }

  @override
  void dispose() {
    controller.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      ),
    );
  }
}
