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

class _ChatMessageWidgetState extends State<ChatMessageWidget> with ChatUtils {
  @override
  Widget build(BuildContext context) {
    final bool isCurrentMessageSender = widget.message.isSender;
    final MessageStatus status = widget.message.messageStatus;

    final chat = context.select((ChatCubit cubit) => cubit.state.currentChat);
    final fBorderRadius = borderRadius(message: widget.message, nextMessage: widget.nextMessage, previousMessage: widget.previousMessage);
    return ShimmerWidget.fromChild(
      isLoading: widget._isSkeleton,
      child: Center(
        child: Row(
          mainAxisAlignment: isCurrentMessageSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (showReceiverImage(
              widget.message,
              widget.nextMessage,
            )) ...[
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
                        borderRadius: fBorderRadius,
                        color: getMessageColor(context, widget.message),
                      ),
                      child: messageContaint(widget.message),
                    )
                  : Container(
                      padding: REdgeInsets.symmetric(horizontal: 20.0 * 0.75, vertical: 20.0 / 2),
                      decoration: BoxDecoration(
                        color: getMessageColor(context, widget.message),
                        borderRadius: fBorderRadius,
                      ),
                      child: messageContaint(widget.message),
                    ),
            ),
            if (showMessageStatus(widget.message, widget.nextMessage)) ...[
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
