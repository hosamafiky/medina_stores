part of '../data_imports.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  const ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<Chat>>>> getChats(GetPaginatedListParams params) async {
    return await remoteDataSource.getChats(params).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<ChatMessage>>>> getChatMessages(GetMessagesParams params) async {
    return await remoteDataSource.getChat(params).handleCallbackWithFailure;
  }
}
