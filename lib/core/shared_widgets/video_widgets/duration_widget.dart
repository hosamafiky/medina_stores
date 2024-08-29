part of 'video_widget.dart';

class DurationWidget extends StatelessWidget {
  const DurationWidget({
    super.key,
    required this.controller,
    this.textColor,
  });

  final CachedVideoPlayerPlusController controller;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;
    bool durationClicked = false;

    return ValueListenableBuilder<CachedVideoPlayerPlusValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        String getDuration() {
          if (!value.isPlaying) return '${value.duration.inMinutes.padNumber}:${value.duration.inSeconds.remainder(60).padNumber}';
          if (durationClicked) {
            return '- ${(value.duration - value.position).inMinutes.padNumber}:${(value.duration - value.position).inSeconds.remainder(60).padNumber}';
          }

          return '${value.position.inMinutes.padNumber}:${value.position.inSeconds.remainder(60).padNumber}';
        }

        return InkWell(
          onTap: () => durationClicked = !durationClicked,
          child: Text(
            getDuration(),
            style: TextStyle(
              color: textColor ?? palette.primary,
              fontSize: 12.sp,
            ),
          ),
        );
      },
    );
  }
}
