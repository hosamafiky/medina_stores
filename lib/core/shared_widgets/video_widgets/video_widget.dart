import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/media_view/presentation/presentation_imports.dart';
import '../../extensions/context.dart';
import '../../extensions/int.dart';
import '../../navigation/navigator.dart';

part 'duration_widget.dart';
part 'play_pause_button.dart';
part 'volume_button.dart';

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
  late final CachedVideoPlayerPlusController controller;

  @override
  void initState() {
    _initializeController();
    super.initState();
  }

  void _initializeController() async {
    controller = CachedVideoPlayerPlusController.networkUrl(Uri.parse(widget.mediaUrl));
    await controller.setLooping(true);
    await controller.initialize().then((_) => setState(() {}));
    await controller.setVolume(0.0);
    await controller.setLooping(false);
    if (widget.autoStart) await controller.play();
  }

  @override
  void dispose() {
    controller.pause();
    controller.dispose();
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
              child: CachedVideoPlayerPlus(controller),
            ),
          ),
          PlayPauseButton(controller: controller),
          PositionedDirectional(
            end: 10.w,
            bottom: 10.h,
            child: VolumeButton(controller: controller),
          ),
          PositionedDirectional(
            start: 10.w,
            bottom: 10.h,
            child: DurationWidget(controller: controller),
          ),
        ],
      ),
    );
  }
}
