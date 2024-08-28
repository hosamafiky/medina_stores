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
    await controller.setVolume(0.0);
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
      width: widget.width ?? context.screenWidth,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: widget.height,
            width: widget.width ?? context.screenWidth,
            decoration: BoxDecoration(
              color: palette.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          InkWell(
            onTap: () => AppNavigator.to(VideoViewPage(controller)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: VideoPlayer(controller),
            ),
          ),
          PlayPauseButton(controller: controller),
          PositionedDirectional(
            end: 10.w,
            bottom: 10.h,
            child: VolumeButton(controller: controller),
          ),
        ],
      ),
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    super.key,
    required this.controller,
  });

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;
    return ValueListenableBuilder(
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
            height: 50.r,
            width: 50.r,
            decoration: BoxDecoration(
              color: palette.primary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: !value.isInitialized
                ? const CircularProgressIndicator.adaptive()
                : Icon(
                    value.isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 32,
                    color: Colors.white,
                  ),
          ),
        );
      },
    );
  }
}

class VolumeButton extends StatelessWidget {
  const VolumeButton({
    super.key,
    required this.controller,
  });

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;

    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            if (value.volume > 0) {
              controller.setVolume(0.0);
              return;
            }
            controller.setVolume(1.0);
          },
          child: Container(
            height: 20.r,
            width: 20.r,
            decoration: BoxDecoration(
              color: palette.primary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              value.volume > 0 ? Icons.volume_up : Icons.volume_off,
              size: 15,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
