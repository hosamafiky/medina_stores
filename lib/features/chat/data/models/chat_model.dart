part of '../data_imports.dart';

class ChatModel extends Chat {
  const ChatModel({
    required super.id,
    required super.receiverName,
    required super.receiverProfileImage,
    required super.isReceiverActive,
    required super.lastMessage,
    required super.lastMessageTime,
    required super.hasUnreadMessages,
  });

  factory ChatModel.fromChat(Chat chat) {
    return ChatModel(
      id: chat.id,
      receiverName: chat.receiverName,
      receiverProfileImage: chat.receiverProfileImage,
      isReceiverActive: chat.isReceiverActive,
      lastMessage: chat.lastMessage,
      lastMessageTime: chat.lastMessageTime,
      hasUnreadMessages: chat.hasUnreadMessages,
    );
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'],
      receiverName: map['receiver_name'],
      receiverProfileImage: map['receiver_profile_image'],
      isReceiverActive: map['is_receiver_active'],
      lastMessage: map['last_message'],
      lastMessageTime: DateFormat(ApiConstants.dateFormat).parse(map['last_message_time']),
      hasUnreadMessages: map['has_unread_messages'],
    );
  }

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'receiver_name': receiverName,
      'receiver_profile_image': receiverProfileImage,
      'is_receiver_active': isReceiverActive,
      'last_message': lastMessage,
      'last_message_time': DateFormat(ApiConstants.dateFormat).format(lastMessageTime),
      'has_unread_messages': hasUnreadMessages,
    };
  }

  String toJson() => json.encode(toMap());
}
