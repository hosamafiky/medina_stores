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
    return Column(
      crossAxisAlignment: widget.message.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            VideoWidget(
              height: 130.h,
              width: 0.55.sw,
              mediaUrl: widget.message.mediaUrl!,
            ),
            if (widget.message.isSender) MessageStatusDot(status: widget.message.messageStatus),
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