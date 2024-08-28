part of '../presentation_imports.dart';

class VideoViewPage extends StatelessWidget {
  const VideoViewPage(this.videoController, {super.key});

  final VideoPlayerController videoController;

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
              child: VideoPlayer(videoController),
            ),
          ),
          Padding(
            padding: REdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                ValueListenableBuilder(
                  valueListenable: videoController,
                  builder: (context, value, child) {
                    return InkWell(
                      onTap: () {
                        if (value.isPlaying) {
                          videoController.pause();
                        } else {
                          videoController.play();
                        }
                      },
                      child: Icon(
                        value.isPlaying ? Icons.pause : Icons.play_arrow,
                        color: ColorPalette.whiteColor,
                        size: 50,
                      ),
                    );
                  },
                ),
                const Spacer(),
                VideoProgressIndicator(
                  videoController,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: palette.primary,
                    bufferedColor: ColorPalette.whiteColor.withOpacity(0.5),
                    backgroundColor: ColorPalette.whiteColor.withOpacity(0.2),
                  ),
                ),
                SizedBox(height: 160.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
