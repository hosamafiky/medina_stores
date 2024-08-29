part of '../presentation_imports.dart';

class VideoViewPage extends StatelessWidget {
  const VideoViewPage(this.videoController, {super.key});

  final CachedVideoPlayerPlusController videoController;

  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const MainAppBar(
        backgroundColor: Colors.transparent,
        iconColor: ColorPalette.whiteColor,
      ),
      backgroundColor: ColorPalette.blackColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: videoController.value.aspectRatio,
              child: CachedVideoPlayerPlus(videoController),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: REdgeInsets.all(16.0).copyWith(bottom: 16.h + context.bottomBarHeight),
              decoration: BoxDecoration(
                color: palette.cardBackground.withOpacity(0.1),
              ),
              child: Column(
                children: [
                  VideoProgressIndicator(
                    videoController,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      playedColor: palette.primary,
                      bufferedColor: ColorPalette.whiteColor.withOpacity(0.5),
                      backgroundColor: ColorPalette.whiteColor.withOpacity(0.2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      VolumeButton(controller: videoController),
                      DurationWidget(
                        controller: videoController,
                        textColor: ColorPalette.whiteColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          PlayPauseButton(controller: videoController),
        ],
      ),
    );
  }
}
