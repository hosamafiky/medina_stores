// ignore_for_file: must_be_immutable

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
    final fBorderRadius = chatBubleBorderRadius(message: widget.message, nextMessage: widget.nextMessage, previousMessage: widget.previousMessage);
    return ShimmerWidget.fromChild(
      isLoading: widget._isSkeleton,
      child: Center(
        child: Row(
          mainAxisAlignment: isCurrentMessageSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (showReceiverImage(widget.message, widget.nextMessage)) ...[
              Align(
                alignment: AlignmentDirectional.bottomStart,
                child: ImageWidget(
                  imageUrl: chat!.receiverProfileImage,
                  height: 40.w,
                  width: 40.w,
                  isClickable: false,
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
                        color: getMessageColor(widget.message),
                      ),
                      child: messageContaint(widget.message),
                    )
                  : Container(
                      padding: REdgeInsets.symmetric(horizontal: 20.0 * 0.75, vertical: 20.0 / 2),
                      decoration: BoxDecoration(
                        color: getMessageColor(widget.message),
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

class MessageStatusDot extends StatefulWidget {
  final MessageStatus? status;

  const MessageStatusDot({super.key, this.status});

  @override
  State<MessageStatusDot> createState() => _MessageStatusDotState();
}

class _MessageStatusDotState extends State<MessageStatusDot> with ChatUtils {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.only(left: 20 / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(widget.status!),
        shape: BoxShape.circle,
      ),
      child: Icon(
        widget.status == MessageStatus.notSent ? Icons.close : Icons.done,
        size: 8.r,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
