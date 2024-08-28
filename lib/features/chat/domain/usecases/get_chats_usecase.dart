part of '../domain_imports.dart';

class GetChatsUsecase implements UseCase<ApiResponse<PaginatedList<Chat>>, GetPaginatedListParams> {
  final ChatRepository repository;

  const GetChatsUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<Chat>>>> call(GetPaginatedListParams param) async {
    return await repository.getChats(param);
  }
}
