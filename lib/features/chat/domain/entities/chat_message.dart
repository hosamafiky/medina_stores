part of '../domain_imports.dart';

enum ChatMessageType {
  text,
  audio,
  image,
  attachment,
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
  final List<File>? files;
  final String? mediaUrl;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  const ChatMessage({
    this.id = 0,
    this.text = '',
    this.mediaUrl,
    this.files,
    this.messageType = ChatMessageType.text,
    this.messageStatus = MessageStatus.viewed,
    this.isSender = true,
  }) : assert(
          ((messageType == ChatMessageType.image ||
                      messageType == ChatMessageType.audio ||
                      messageType == ChatMessageType.video ||
                      messageType == ChatMessageType.attachment) &&
                  (mediaUrl != null || files != null)) ||
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
    List<File>? files,
    ChatMessageType? messageType,
    MessageStatus? messageStatus,
    bool? isSender,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      files: files ?? this.files,
      messageType: messageType ?? this.messageType,
      messageStatus: messageStatus ?? this.messageStatus,
      isSender: isSender ?? this.isSender,
    );
  }

  @override
  List<Object?> get props => [id, text, messageType, files, mediaUrl, messageStatus, isSender];
}
