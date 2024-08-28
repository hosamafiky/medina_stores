part of '../domain_imports.dart';

abstract class ChatRepository {
  Future<Either<Failure, ApiResponse<PaginatedList<Chat>>>> getChats(GetPaginatedListParams params);
}
