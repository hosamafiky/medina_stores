part of 'video_widget.dart';

class VolumeButton extends StatelessWidget {
  const VolumeButton({
    super.key,
    required this.controller,
  });

  final CachedVideoPlayerPlusController controller;

  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;

    return ValueListenableBuilder<CachedVideoPlayerPlusValue>(
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
