part of '../presentation_imports.dart';

class AudioMessage extends ChatMessageWidget {
  const AudioMessage(super.message, {super.key});

  @override
  AudioMessageState createState() => AudioMessageState();
}

class AudioMessageState extends State<AudioMessage> with ChatUtils, AudioUtils {
  final player = AudioPlayer();

  @override
  void initState() {
    initializeSource(widget.message.mediaUrl!, player);
    super.initState();
  }

  void play() async {
    if (!mounted) return;
    await player.play();
  }

  void pause() async {
    if (!mounted) return;
    await player.pause();
  }

  void stop() async {
    if (!mounted) return;
    await player.stop();
    seek(Duration.zero);
  }

  void seek(Duration position) async {
    if (!mounted) return;
    await player.seek(position);
  }

  @override
  void dispose() {
    player.pause();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;
    return SizedBox(
      width: 0.55.sw,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: widget.message.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                StreamBuilder<PlayerState>(
                  stream: player.playerStateStream,
                  builder: (context, snapshot) {
                    if (snapshot.data?.processingState == ProcessingState.loading) {
                      return const CircularProgressIndicator.adaptive();
                    }
                    final isPlaying = snapshot.data?.playing ?? false;
                    return IconButton(
                      onPressed: () {
                        if (isPlaying) {
                          pause();
                          return;
                        }
                        play();
                      },
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: widget.message.isSender ? ColorPalette.whiteColor : palette.primary,
                      ),
                    );
                  },
                ),
                Expanded(
                  child: StreamBuilder<(Duration, Duration?)>(
                    stream: durationStream(player),
                    builder: (context, durationSnapshot) {
                      final audioDuration = durationSnapshot.data?.$2 ?? Duration.zero;
                      final currentPosition = durationSnapshot.data?.$1 ?? Duration.zero;
                      if (currentPosition.inSeconds == audioDuration.inSeconds && player.playing) stop();

                      return Padding(
                        padding: REdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: SliderTheme(
                                data: SliderThemeData(
                                  trackHeight: 2,
                                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 2),
                                  inactiveTrackColor: getInActiveTrackColor(widget.message.isSender),
                                  activeTrackColor: getActiveTrackColor(widget.message.isSender),
                                  trackShape: const RoundedRectSliderTrackShape(),
                                  thumbColor: widget.message.isSender ? ColorPalette.whiteColor : palette.primary,
                                ),
                                child: Slider(
                                  value: currentPosition.inSeconds.toDouble(),
                                  min: 0,
                                  thumbColor: palette.primary,
                                  max: audioDuration.inSeconds.toDouble(),
                                  onChanged: (position) => seek(Duration(seconds: position.toInt())),
                                  onChangeStart: (position) => player.pause(),
                                  onChangeEnd: (position) => player.play(),
                                ),
                              ),
                            ),
                            Text(
                              getAudioDuration(player.playing ? currentPosition : audioDuration),
                              style: TextStyle(fontSize: 12.sp, color: widget.message.isSender ? ColorPalette.whiteColor : null),
                            ),
                          ],
                        ).withSpacing(spacing: 8.w),
                      );
                    },
                  ),
                ),
              ],
            ),
            if (widget.message.text.isNotEmpty)
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.message.text,
                  maxLines: 10,
                  style: context.appTextStyle.fieldStyle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
