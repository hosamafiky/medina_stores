import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/core/extensions/context.dart';
import 'package:medina_stores/core/navigation/navigator.dart';
import 'package:medina_stores/features/chat/domain/domain_imports.dart';

import '../../features/chat/presentation/presentation_imports.dart';

mixin ChatUtils {
  final context = AppNavigator.rootContext!;

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

  Color getMessageColor(ChatMessage message) {
    final bool isCurrentMessageSender = message.isSender;
    final MessageStatus status = message.messageStatus;

    if (isCurrentMessageSender) {
      if (status == MessageStatus.notSent) {
        return context.colorPalette.error.withOpacity(0.6);
      }
      return context.colorPalette.primary.withOpacity(0.5);
    }
    return context.colorPalette.primary.withOpacity(0.1);
  }

  bool showMessageStatus(ChatMessage message, ChatMessage? nextMessage) {
    final bool isCurrentMessageSender = message.isSender;
    final MessageStatus status = message.messageStatus;

    if (!isCurrentMessageSender) return false;

    if (status == MessageStatus.notSent || (isCurrentMessageSender && nextMessage == null && !isCurrentMessageSender)) {
      return status == MessageStatus.notSent;
    }
    return false;
  }

  bool showReceiverImage(
    ChatMessage message,
    ChatMessage? nextMessage,
  ) {
    final isCurrentMessageSender = message.isSender;
    final isNextMessageSender = nextMessage?.isSender ?? false;

    if (isCurrentMessageSender) return false;
    if (!isNextMessageSender) return false;
    if (isNextMessageSender) return true;
    return false;
  }

  BorderRadiusGeometry borderRadius({
    required ChatMessage message,
    required ChatMessage? nextMessage,
    required ChatMessage? previousMessage,
  }) {
    final bool isNextMessageSender = nextMessage?.isSender ?? false;
    final bool isCurrentMessageSender = message.isSender;
    final bool isPreviousMessageSender = previousMessage?.isSender ?? false;
    if (previousMessage == null || nextMessage == null) {
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

  Color dotColor(MessageStatus status) {
    switch (status) {
      case MessageStatus.notSent:
        return context.colorPalette.error;
      case MessageStatus.notView:
        return Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.1);
      case MessageStatus.viewed:
        return context.colorPalette.primary;

      default:
        return Colors.transparent;
    }
  }
}
