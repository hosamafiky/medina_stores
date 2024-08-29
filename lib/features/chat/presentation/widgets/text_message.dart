part of '../presentation_imports.dart';

class TextMessage extends ChatMessageWidget {
  const TextMessage(super.message, {super.key});

  @override
  TextMessageState createState() => TextMessageState();
}

class TextMessageState extends State<TextMessage> {
  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;
    final appStyles = context.appTextStyle;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0 * 0.75, vertical: 20.0 / 2),
      decoration: BoxDecoration(
        color: palette.primary.withOpacity(
          widget.message.isSender ? 0.5 : 0.1,
        ),
      ),
      child: Text(
        widget.message.text,
        maxLines: 10,
        style: appStyles.fieldStyle,
      ),
    );
  }
}
