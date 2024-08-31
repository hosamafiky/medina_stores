part of '../data_imports.dart';

class ChatMessageModel extends ChatMessage {
  const ChatMessageModel({
    required super.id,
    required super.messageType,
    required super.messageStatus,
    required super.isSender,
    super.text = '',
    super.mediaUrl,
  });

  factory ChatMessageModel.fromMessage(ChatMessage message) {
    return ChatMessageModel(
      id: message.id,
      messageType: message.messageType,
      messageStatus: message.messageStatus,
      isSender: message.isSender,
      text: message.text,
      mediaUrl: message.mediaUrl,
    );
  }

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      id: map['id'],
      messageType: ChatMessageType.fromString(map['message_type']),
      messageStatus: MessageStatus.fromString(map['message_status']),
      isSender: map['is_sender'],
      text: map['text'],
      mediaUrl: map['media_url'],
    );
  }

  factory ChatMessageModel.fromJson(String source) => ChatMessageModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "message_type": messageType.name,
      "message_status": messageStatus.name,
      "is_sender": isSender,
      "text": text,
      "media_url": mediaUrl,
    };
  }

  String toJson() => json.encode(toMap());
}
