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
    final bool isNextMessageSender = widget.nextMessage?.isSender ?? false;
    final bool isCurrentMessageSender = widget.message.isSender;
    final bool isPreviousMessageSender = widget.previousMessage?.isSender ?? false;
    if (widget.previousMessage == null || widget.nextMessage == null) {
      return BorderRadius.circular(20);
    }
    final isSender = (isCurrentMessageSender && isNextMessageSender);
    if (isSender) {
      if (!isPreviousMessageSender) {
        return BorderRadiusDirectional.only(
          topStart: Radius.circular(20.r),
          topEnd: Radius.circular(20.r),
          bottomStart: Radius.circular(20.r),
          bottomEnd: Radius.circular(5.r),
        );
      }

      if (isPreviousMessageSender && isNextMessageSender) {
        return BorderRadiusDirectional.horizontal(
          start: Radius.circular(20.r),
          end: Radius.circular(5.r),
        );
      }

      return BorderRadiusDirectional.horizontal(
        start: Radius.circular(20.r),
        end: Radius.circular(5.r),
      );
    }
    final isReceiver = (!isCurrentMessageSender && !isNextMessageSender);
    if (isReceiver) {
      if (isPreviousMessageSender) {
        return BorderRadiusDirectional.only(
          topStart: Radius.circular(20.r),
          topEnd: Radius.circular(20.r),
          bottomStart: Radius.circular(5.r),
          bottomEnd: Radius.circular(20.r),
        );
      }
      if (!isPreviousMessageSender && !isNextMessageSender) {
        return BorderRadiusDirectional.horizontal(
          start: Radius.circular(5.r),
          end: Radius.circular(20.r),
        );
      }
      return BorderRadiusDirectional.horizontal(
        start: Radius.circular(20.r),
        end: Radius.circular(20.r),
      );
    }
    final ifLastMessageSent = (isCurrentMessageSender && !isNextMessageSender && isPreviousMessageSender);
    if (ifLastMessageSent) {
      return BorderRadiusDirectional.only(
        topStart: Radius.circular(20.r),
        topEnd: Radius.circular(5.r),
        bottomStart: Radius.circular(20.r),
        bottomEnd: Radius.circular(20.r),
      );
    }
    final ifLastMessageReceived = (!isCurrentMessageSender && isNextMessageSender && !isPreviousMessageSender);
    if (ifLastMessageReceived) {
      return BorderRadiusDirectional.only(
        topStart: Radius.circular(5.r),
        topEnd: Radius.circular(20.r),
        bottomStart: Radius.circular(20.r),
        bottomEnd: Radius.circular(20.r),
      );
    }
    return BorderRadius.circular(20.r);
  }

  Color getMessageColor() {
    final bool isCurrentMessageSender = widget.message.isSender;
    final MessageStatus status = widget.message.messageStatus;

    if (isCurrentMessageSender) {
      if (status == MessageStatus.notSent) {
        return context.colorPalette.error.withOpacity(0.6);
      }
      return context.colorPalette.primary.withOpacity(0.5);
    }
    return context.colorPalette.primary.withOpacity(0.1);
  }

  bool get showMessageStatus {
    final bool isCurrentMessageSender = widget.message.isSender;
    final MessageStatus status = widget.message.messageStatus;

    if (!isCurrentMessageSender) return false;

    if (status == MessageStatus.notSent || (isCurrentMessageSender && widget.nextMessage == null && !isCurrentMessageSender)) {
      return status == MessageStatus.notSent;
    }
    return false;
  }

  bool get showReceiverImage {
    final bool isCurrentMessageReceiver = !widget.message.isSender;
    final bool isNextMessageReceiver = !(widget.nextMessage?.isSender ?? false);
    if (!isCurrentMessageReceiver) return false;
    if (isNextMessageReceiver) return false;
    if (!isNextMessageReceiver) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final bool isCurrentMessageSender = widget.message.isSender;
    final MessageStatus status = widget.message.messageStatus;

    final chat = context.select((ChatCubit cubit) => cubit.state.currentChat);
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
      child: Center(
        child: Row(
          mainAxisAlignment: isCurrentMessageSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (showReceiverImage) ...[
              Align(
                alignment: AlignmentDirectional.bottomStart,
                child: ImageWidget(
                  imageUrl: chat!.receiverProfileImage,
                  height: 40.w,
                  width: 40.w,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 10.w),
            ] else ...[
              SizedBox(width: 50.w),
            ],
            Align(
              child: (widget.message.messageType == ChatMessageType.audio || widget.message.messageType == ChatMessageType.text)
                  ? DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: borderRadius,
                        color: getMessageColor(),
                      ),
                      child: messageContaint(widget.message),
                    )
                  : Container(
                      padding: REdgeInsets.symmetric(horizontal: 20.0 * 0.75, vertical: 20.0 / 2),
                      decoration: BoxDecoration(
                        color: getMessageColor(),
                        borderRadius: borderRadius,
                      ),
                      child: messageContaint(widget.message),
                    ),
            ),
            if (showMessageStatus) ...[
              Align(
                alignment: Alignment.centerRight,
                child: MessageStatusDot(status: status),
              ),
            ]
          ],
        ),
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
