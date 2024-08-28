part of '../presentation_imports.dart';

class ChatState extends Equatable {
  const ChatState({
    this.chatsStatus = UsecaseStatus.idle,
    this.messagesStatus = UsecaseStatus.idle,
    this.chatsFailure,
    this.messagesFailure,
    this.currentChat,
    this.chats = const ApiResponse.success(data: PaginatedList(data: [])),
    this.messages = const ApiResponse.success(data: PaginatedList(data: [])),
  });

  final UsecaseStatus chatsStatus;
  final UsecaseStatus messagesStatus;
  final Failure? chatsFailure;
  final Failure? messagesFailure;
  final Chat? currentChat;
  final ApiResponse<PaginatedList<Chat>> chats;
  final ApiResponse<PaginatedList<ChatMessage>> messages;

  ChatState copyWith({
    UsecaseStatus? chatsStatus,
    UsecaseStatus? messagesStatus,
    Failure? chatsFailure,
    Failure? messagesFailure,
    Chat? currentChat,
    ApiResponse<PaginatedList<Chat>>? chats,
    ApiResponse<PaginatedList<ChatMessage>>? messages,
  }) {
    return ChatState(
      chatsStatus: chatsStatus ?? this.chatsStatus,
      messagesStatus: messagesStatus ?? this.messagesStatus,
      chatsFailure: chatsFailure ?? this.chatsFailure,
      messagesFailure: messagesFailure ?? this.messagesFailure,
      currentChat: currentChat ?? this.currentChat,
      chats: chats ?? this.chats,
      messages: messages ?? this.messages,
    );
  }

  @override
  String toString() {
    return 'ChatState(chatsStatus: $chatsStatus, messagesStatus: $messagesStatus, chatsFailure: $chatsFailure, messagesFailure: $messagesFailure, currentChat: $currentChat, chats: $chats, messages: $messages)';
  }

  @override
  List<Object?> get props => [
        chatsStatus,
        messagesStatus,
        chatsFailure,
        messagesFailure,
        currentChat,
        chats,
        messages,
      ];
}
