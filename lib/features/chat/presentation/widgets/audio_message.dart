part of '../presentation_imports.dart';

class AudioMessage extends ChatMessageWidget {
  const AudioMessage(super.message, {super.key});

  @override
  AudioMessageState createState() => AudioMessageState();
}

class AudioMessageState extends State<AudioMessage> {
  final Duration _audioDuration = const Duration(minutes: 1, seconds: 34);
  Duration _currentPosition = const Duration(minutes: 0, seconds: 0);

  bool isPlaying = false;

  Timer? timer;

  void play() {
    if (!mounted) return;

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      isPlaying = true;
      if (_currentPosition.inSeconds < _audioDuration.inSeconds) {
        setState(() {
          _currentPosition = Duration(seconds: _currentPosition.inSeconds + 1);
        });
      } else {
        setState(() {
          isPlaying = false;
          _currentPosition = const Duration(minutes: 0, seconds: 0);
        });
        timer?.cancel();
      }
    });
  }

  void pause() {
    if (!mounted) return;
    setState(() {
      isPlaying = false;
    });
    timer?.cancel();
  }

  @override
  void dispose() {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    super.dispose();
  }

  Color getInActiveTrackColor() {
    if (widget.message.isSender) {
      return Colors.white.withOpacity(0.48);
    }
    return context.colorPalette.primary.withOpacity(0.24);
  }

  Color getActiveTrackColor() {
    if (widget.message.isSender) {
      return Colors.white;
    }
    return context.colorPalette.primary;
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: const EdgeInsets.symmetric(
        horizontal: 20 * 0.75,
        vertical: 20 / 2.5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: palette.primary.withOpacity(widget.message.isSender ? 1 : 0.1),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (isPlaying) {
                pause();
                return;
              }
              play();
            },
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: widget.message.isSender ? Colors.white : palette.primary,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20 / 2),
              child: SliderTheme(
                data: SliderThemeData(
                  trackHeight: 2,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 2),
                  inactiveTrackColor: getInActiveTrackColor(),
                  activeTrackColor: getActiveTrackColor(),
                  trackShape: const RoundedRectSliderTrackShape(),
                  thumbColor: widget.message.isSender ? ColorPalette.whiteColor : palette.primary,
                ),
                child: Slider(
                  value: _currentPosition.inSeconds.toDouble(),
                  min: 0,
                  thumbColor: palette.primary,
                  max: _audioDuration.inSeconds.toDouble(),
                  onChanged: (position) {
                    //TODO: Implement seek functionality
                  },
                ),
              ),
            ),
          ),
          Text(
            "${(isPlaying ? _currentPosition : _audioDuration).inMinutes.padNumber}:${(isPlaying ? _currentPosition : _audioDuration).inSeconds.padNumber}",
            style: TextStyle(fontSize: 12, color: widget.message.isSender ? Colors.white : null),
          ),
        ],
      ),
    );
  }
}
