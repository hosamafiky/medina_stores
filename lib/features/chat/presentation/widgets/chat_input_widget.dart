part of '../presentation_imports.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({
    super.key,
    required this.onMicPressed,
    required this.onEmojiPressed,
    required this.onAttachmentPressed,
    required this.onCameraPressed,
  });

  final Function() onMicPressed;
  final Function() onEmojiPressed;
  final Function() onAttachmentPressed;
  final Function() onCameraPressed;

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> with ChatUtils {
  final _messageController = TextEditingController();

  @override
  void initState() {
    _messageController.addListener(() {
      if (_messageController.text.isNotEmpty) {
        setShowingSendButton(true);
      } else {
        setShowingSendButton(false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20 / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            ValueListenableBuilder(
              valueListenable: showSendButton,
              builder: (context, value, child) {
                return Visibility(
                  visible: !value,
                  replacement: InkWell(
                    onTap: () {
                      final message = ChatMessage(text: _messageController.text);
                      context.read<ChatCubit>().sendMessage(message);
                    },
                    child: Transform.flip(
                      flipX: context.locale.languageCode == "en",
                      child: Icon(Icons.send, color: palette.primary),
                    ),
                  ),
                  child: InkWell(
                    onTap: widget.onMicPressed,
                    child: Icon(Icons.mic, color: palette.primary),
                  ),
                );
              },
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Container(
                padding: REdgeInsets.symmetric(horizontal: 20 * 0.75),
                decoration: BoxDecoration(
                  color: palette.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: widget.onEmojiPressed,
                      child: Icon(
                        Icons.sentiment_satisfied_alt_outlined,
                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.64),
                      ),
                    ),
                    SizedBox(width: 20.h / 4),
                    Expanded(
                      child: AppTextField(
                        controller: _messageController,
                        hintText: "Type message",
                        isBordered: false,
                      ),
                    ),
                    InkWell(
                      onTap: widget.onAttachmentPressed,
                      child: Icon(
                        Icons.attach_file,
                        color: palette.primary.withOpacity(0.64),
                      ),
                    ),
                    SizedBox(width: 20.h / 4),
                    InkWell(
                      onTap: widget.onCameraPressed,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: palette.primary.withOpacity(0.64),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
