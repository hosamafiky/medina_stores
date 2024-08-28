part of '../presentation_imports.dart';

class ImageMessage extends ChatMessageWidget {
  const ImageMessage(super.message, {super.key});

  @override
  ImageMessageState createState() => ImageMessageState();
}

class ImageMessageState extends State<ImageMessage> {
  @override
  Widget build(BuildContext context) {
    final appStyles = context.appTextStyle;

    return Column(
      crossAxisAlignment: widget.message.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        ImageWidget(
          height: 130.h,
          width: 0.55.sw,
          borderRadius: BorderRadius.circular(8),
          imageUrl: widget.message.mediaUrl!,
        ),
        if (widget.message.text.isNotEmpty) Text(widget.message.text, style: appStyles.fieldStyle),
      ],
    ).withSpacing(spacing: 16.h);
  }
}
