import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/core/extensions/context.dart';
import 'package:medina_stores/core/navigation/navigator.dart';
import 'package:video_player/video_player.dart';

import '../../../features/media_view/presentation/presentation_imports.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    super.key,
    required this.mediaUrl,
    this.autoStart = false,
    this.width,
    this.height,
  });
  final String mediaUrl;
  final double? width, height;
  final bool autoStart;

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
    if (widget.autoStart) await controller.play();
  }

  @override
  void dispose() {
    controller.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          InkWell(
            onTap: () {
              AppNavigator.to(VideoViewPage(controller));
            },
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: VideoPlayer(controller),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, value, child) {
              return InkWell(
                onTap: () {
                  if (value.isPlaying) {
                    controller.pause();
                  } else {
                    controller.play();
                  }
                },
                child: Container(
                  height: 25.r,
                  width: 25.r,
                  decoration: BoxDecoration(
                    color: palette.primary.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    value.isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
