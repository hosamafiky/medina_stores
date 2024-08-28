part of '../domain_imports.dart';

class Chat extends Equatable {
  final int id;
  final String receiverName;
  final String receiverProfileImage;
  final bool isReceiverActive;
  final String lastMessage;
  final DateTime lastMessageTime;
  final bool hasUnreadMessages;

  const Chat({
    required this.id,
    required this.receiverName,
    required this.receiverProfileImage,
    required this.isReceiverActive,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.hasUnreadMessages,
  });

  static Chat empty() => Chat(
        id: 0,
        receiverName: '',
        receiverProfileImage: '',
        isReceiverActive: false,
        lastMessage: '',
        lastMessageTime: DateTime.now(),
        hasUnreadMessages: false,
      );

  Chat copyWith({
    int? id,
    String? receiverName,
    String? receiverProfileImage,
    bool? isReceiverActive,
    String? lastMessage,
    DateTime? lastMessageTime,
    bool? hasUnreadMessages,
  }) {
    return Chat(
      id: id ?? this.id,
      receiverName: receiverName ?? this.receiverName,
      receiverProfileImage: receiverProfileImage ?? this.receiverProfileImage,
      isReceiverActive: isReceiverActive ?? this.isReceiverActive,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      hasUnreadMessages: hasUnreadMessages ?? this.hasUnreadMessages,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      receiverName,
      receiverProfileImage,
      isReceiverActive,
      lastMessage,
      lastMessageTime,
      hasUnreadMessages,
    ];
  }
}
