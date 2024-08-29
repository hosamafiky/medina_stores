part of '../presentation_imports.dart';

class TextMessage extends ChatMessageWidget {
  const TextMessage(super.message, {super.key});

  @override
  TextMessageState createState() => TextMessageState();
}

class TextMessageState extends State<TextMessage> {
  @override
  Widget build(BuildContext context) {
    final appStyles = context.appTextStyle;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0 * 0.75, vertical: 20.0 / 2),
      child: Text(
        widget.message.text,
        maxLines: 10,
        style: appStyles.fieldStyle,
      ),
    );
  }
}
