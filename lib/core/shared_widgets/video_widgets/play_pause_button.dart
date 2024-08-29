part of 'video_widget.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    super.key,
    required this.controller,
  });

  final CachedVideoPlayerPlusController controller;

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
