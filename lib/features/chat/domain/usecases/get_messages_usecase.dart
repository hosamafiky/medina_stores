part of '../domain_imports.dart';

class GetMessagesUsecase implements UseCase<ApiResponse<PaginatedList<ChatMessage>>, GetMessagesParams> {
  final ChatRepository repository;

  const GetMessagesUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<ChatMessage>>>> call(GetMessagesParams param) async {
    return await repository.getChatMessages(param);
  }
}

class GetMessagesParams extends GetPaginatedListParams {
  final int chatId;

  const GetMessagesParams({
    required this.chatId,
    super.page,
    super.perPage,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'chat_id': chatId,
      'page': page,
      'perPage': perPage,
    };
  }

  @override
  List<Object?> get props => [chatId, page, perPage];
}
