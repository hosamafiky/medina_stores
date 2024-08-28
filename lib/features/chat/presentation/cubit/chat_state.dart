part of '../presentation_imports.dart';

class ChatState extends Equatable {
  const ChatState({
    this.chatsStatus = UsecaseStatus.idle,
    this.chatsFailure,
    this.chats = const ApiResponse.success(data: PaginatedList(data: [])),
  });

  final UsecaseStatus chatsStatus;
  final Failure? chatsFailure;
  final ApiResponse<PaginatedList<Chat>> chats;

  ChatState copyWith({
    UsecaseStatus? chatsStatus,
    Failure? chatsFailure,
    ApiResponse<PaginatedList<Chat>>? chats,
  }) {
    return ChatState(
      chatsStatus: chatsStatus ?? this.chatsStatus,
      chatsFailure: chatsFailure ?? this.chatsFailure,
      chats: chats ?? this.chats,
    );
  }

  @override
  String toString() {
    return 'ChatState(chatsStatus: $chatsStatus, chatsFailure: $chatsFailure, chats: $chats)';
  }

  @override
  List<Object?> get props => [
        chatsStatus,
        chatsFailure,
        chats,
      ];
}
