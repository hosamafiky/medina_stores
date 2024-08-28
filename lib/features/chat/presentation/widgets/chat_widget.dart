part of '../presentation_imports.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget(this.chat, {super.key}) : _isSkeleton = false;

  ChatWidget.skeleton({super.key})
      : chat = Chat.empty(),
        _isSkeleton = true;

  final Chat chat;
  final bool _isSkeleton;

  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;
    return InkWell(
      onTap: () {
        if (_isSkeleton) return;
        AppNavigator.to(ChatPage(chat));
      },
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: chat.hasUnreadMessages ? palette.primary.withOpacity(0.08) : Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ImageWidget(
                  height: 48.r,
                  width: 48.r,
                  shape: BoxShape.circle,
                  imageUrl: chat.receiverProfileImage,
                ),
                if (chat.isReceiverActive)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 16.h,
                      width: 16.h,
                      decoration: BoxDecoration(
                        color: palette.success,
                        shape: BoxShape.circle,
                        border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 3),
                      ),
                    ),
                  )
              ],
            ),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.receiverName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Opacity(
                    opacity: 0.64,
                    child: Text(
                      chat.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Opacity(
              opacity: 0.64,
              child: Text(DateFormat.jm().format(chat.lastMessageTime)),
            ),
          ],
        ),
      ),
    );
  }
}
