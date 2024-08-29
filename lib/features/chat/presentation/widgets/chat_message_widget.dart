part of '../presentation_imports.dart';

class ChatMessageWidget extends StatefulWidget {
  const ChatMessageWidget(
    this.message, {
    this.previousMessage,
    this.nextMessage,
    super.key,
  }) : _isSkeleton = false;

  ChatMessageWidget.skeleton({super.key})
      : message = ChatMessage.empty(),
        previousMessage = ChatMessage.empty(),
        nextMessage = ChatMessage.empty(),
        _isSkeleton = true;

  final ChatMessage? previousMessage;
  final ChatMessage message;
  final ChatMessage? nextMessage;
  final bool _isSkeleton;

  @override
  State<ChatMessageWidget> createState() => _ChatMessageWidgetState();
}

class _ChatMessageWidgetState extends State<ChatMessageWidget> {
  BorderRadiusGeometry get borderRadius {
    if (widget.previousMessage == null || widget.nextMessage == null) {
      return BorderRadius.circular(20);
    }
    final isSender = (widget.message.isSender && widget.nextMessage!.isSender);
    if (isSender) {
      if (!widget.previousMessage!.isSender) {
        return const BorderRadiusDirectional.only(
          topStart: Radius.circular(20),
          topEnd: Radius.circular(20),
          bottomStart: Radius.circular(20),
          bottomEnd: Radius.circular(5),
        );
      }

      if (widget.previousMessage!.isSender && widget.nextMessage!.isSender) {
        return const BorderRadiusDirectional.horizontal(
          start: Radius.circular(20),
          end: Radius.circular(5),
        );
      }

      return const BorderRadiusDirectional.horizontal(
        start: Radius.circular(20),
        end: Radius.circular(5),
      );
    }
    final isReceiver = (!widget.message.isSender && !widget.nextMessage!.isSender);
    if (isReceiver) {
      if (widget.previousMessage!.isSender) {
        return const BorderRadiusDirectional.only(
          topStart: Radius.circular(20),
          topEnd: Radius.circular(20),
          bottomStart: Radius.circular(5),
          bottomEnd: Radius.circular(20),
        );
      }
      if (!widget.previousMessage!.isSender && !widget.nextMessage!.isSender) {
        return const BorderRadiusDirectional.horizontal(
          start: Radius.circular(5),
          end: Radius.circular(20),
        );
      }
      return const BorderRadiusDirectional.horizontal(
        start: Radius.circular(20),
        end: Radius.circular(20),
      );
    }
    final ifLastMessageSent = (widget.message.isSender && !widget.nextMessage!.isSender && widget.previousMessage!.isSender);
    if (ifLastMessageSent) {
      return const BorderRadiusDirectional.only(
        topStart: Radius.circular(20),
        topEnd: Radius.circular(5),
        bottomStart: Radius.circular(20),
        bottomEnd: Radius.circular(20),
      );
    }
    final ifLastMessageReceived = (!widget.message.isSender && widget.nextMessage!.isSender && !widget.previousMessage!.isSender);
    if (ifLastMessageReceived) {
      return const BorderRadiusDirectional.only(
        topStart: Radius.circular(5),
        topEnd: Radius.circular(20),
        bottomStart: Radius.circular(20),
        bottomEnd: Radius.circular(20),
      );
    }
    return BorderRadius.circular(20);
  }

  @override
  Widget build(BuildContext context) {
    final chat = context.select((ChatCubit cubit) => cubit.state.currentChat);
    final palette = context.colorPalette;
    Widget messageContaint(ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(message);
        case ChatMessageType.image:
          return ImageMessage(message);
        case ChatMessageType.audio:
          return AudioMessage(message);
        case ChatMessageType.video:
          return VideoMessage(message);
        default:
          return const SizedBox();
      }
    }

    return ShimmerWidget.fromChild(
      isLoading: widget._isSkeleton,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: widget.message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!widget.message.isSender) ...[
            ImageWidget(imageUrl: chat!.receiverProfileImage, height: 40, width: 40, shape: BoxShape.circle),
            const SizedBox(width: 20 / 2),
          ],
          if (widget.message.messageType == ChatMessageType.audio || widget.message.messageType == ChatMessageType.text) ...[
            ClipRRect(
              borderRadius: borderRadius,
              child: messageContaint(widget.message),
            )
          ] else ...[
            Container(
              padding: REdgeInsets.symmetric(horizontal: 20.0 * 0.75, vertical: 20.0 / 2),
              decoration: BoxDecoration(
                color: palette.primary.withOpacity(widget.message.isSender ? 0.5 : 0.1),
                borderRadius: borderRadius,
              ),
              child: messageContaint(widget.message),
            ),
          ],
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus? status;

  const MessageStatusDot({super.key, this.status});
  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;

    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.notSent:
          return palette.error;
        case MessageStatus.notView:
          return Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.1);
        case MessageStatus.viewed:
          return palette.primary;

        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: REdgeInsets.only(left: 20 / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status!),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.notSent ? Icons.close : Icons.done,
        size: 8.r,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
