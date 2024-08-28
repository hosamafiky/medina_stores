part of '../domain_imports.dart';

enum ChatMessageType {
  text,
  audio,
  image,
  video;

  static ChatMessageType fromString(String type) {
    return ChatMessageType.values.firstWhere((e) => e.name == type, orElse: () => ChatMessageType.text);
  }
}

enum MessageStatus {
  notSent,
  notView,
  viewed;

  static MessageStatus fromString(String type) {
    return MessageStatus.values.firstWhere((e) => e.name == type, orElse: () => MessageStatus.notSent);
  }
}

class ChatMessage extends Equatable {
  final int id;
  final String text;
  final String? mediaUrl;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  const ChatMessage({
    required this.id,
    this.text = '',
    this.mediaUrl,
    required this.messageType,
    required this.messageStatus,
    required this.isSender,
  }) : assert(
          ((messageType == ChatMessageType.image || messageType == ChatMessageType.audio || messageType == ChatMessageType.video) && mediaUrl != null) ||
              (messageType == ChatMessageType.text),
          'MediaUrl must be provided for image, audio and video messages',
        );

  static ChatMessage empty() => const ChatMessage(
        id: 0,
        text: '',
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.notSent,
        isSender: false,
      );

  ChatMessage copyWith({
    int? id,
    String? text,
    String? mediaUrl,
    ChatMessageType? messageType,
    MessageStatus? messageStatus,
    bool? isSender,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      messageType: messageType ?? this.messageType,
      messageStatus: messageStatus ?? this.messageStatus,
      isSender: isSender ?? this.isSender,
    );
  }

  @override
  List<Object?> get props => [id, text, messageType, mediaUrl, messageStatus, isSender];
}
