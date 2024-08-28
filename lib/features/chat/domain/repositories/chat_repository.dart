part of '../domain_imports.dart';

abstract class ChatRepository {
  Future<Either<Failure, ApiResponse<PaginatedList<Chat>>>> getChats(GetPaginatedListParams params);
  Future<Either<Failure, ApiResponse<PaginatedList<ChatMessage>>>> getChatMessages(GetMessagesParams params);
}
