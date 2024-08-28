part of '../presentation_imports.dart';

class VideoMessage extends ChatMessageWidget {
  const VideoMessage(super.message, {super.key});

  @override
  VideoMessageState createState() => VideoMessageState();
}

class VideoMessageState extends State<VideoMessage> {
  @override
  Widget build(BuildContext context) {
    final appStyles = context.appTextStyle;
    final palette = context.colorPalette;
    return Column(
      crossAxisAlignment: widget.message.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Row(
              children: [
                ImageWidget(
                  height: 130.h,
                  width: 0.55.sw,
                  borderRadius: BorderRadius.circular(8),
                  imageUrl: widget.message.mediaUrl!,
                ),
                if (widget.message.isSender) MessageStatusDot(status: widget.message.messageStatus),
              ],
            ),
            Container(
              height: 25.r,
              width: 25.r,
              decoration: BoxDecoration(
                color: palette.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                size: 16,
                color: Colors.white,
              ),
            )
          ],
        ),
        if (widget.message.text.isNotEmpty)
          Padding(
            padding: REdgeInsetsDirectional.only(end: widget.message.isSender ? 20 : 0),
            child: Text(widget.message.text, style: appStyles.fieldStyle),
          ),
      ],
    ).withSpacing(spacing: 16.h);
  }
}
