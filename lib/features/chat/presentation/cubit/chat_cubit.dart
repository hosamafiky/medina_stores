part of '../presentation_imports.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.getChatsUsecase,
  }) : super(const ChatState());

  final GetChatsUsecase getChatsUsecase;

  Future<void> getChats([int? page]) async {
    if (state.chats.data?.hasReachedEnd == true) return;
    if (state.chats.data?.currentPage == 0) emit(state.copyWith(chatsStatus: UsecaseStatus.running));
    if (page != null) emit(state.copyWith(chats: const ApiResponse.success(data: PaginatedList<ChatModel>(data: []))));

    final params = GetPaginatedListParams(page: page ?? (state.chats.data!.currentPage) + 1, perPage: 5);
    final result = await getChatsUsecase(params);
    result.fold(
      (failure) => emit(state.copyWith(
        chatsStatus: UsecaseStatus.error,
        chatsFailure: failure,
      )),
      (chats) {
        final newChats = List<ChatModel>.from(chats.data!.data.map((e) => ChatModel.fromChat(e)));

        if (newChats.isEmpty) {
          final paginatedList = state.chats.data?.copyWith(
            data: state.chats.data!.data.map<ChatModel>((e) => ChatModel.fromChat(e)).toList(),
            hasReachedEnd: true,
          );
          emit(state.copyWith(
            chatsStatus: UsecaseStatus.completed,
            chats: chats.copyWithSuccess(data: paginatedList),
          ));
        } else {
          final oldChats = List<ChatModel>.from(state.chats.data!.data.map((e) => ChatModel.fromChat(e)));
          final paginatedList = PaginatedList<ChatModel>(
            data: [...oldChats, ...newChats],
            currentPage: chats.data!.currentPage,
            lastPage: chats.data!.lastPage,
            itemsCount: chats.data!.itemsCount,
            hasReachedEnd: chats.data!.hasReachedEnd,
          );
          emit(state.copyWith(
            chatsStatus: UsecaseStatus.completed,
            chats: chats.copyWithSuccess(
              data: paginatedList,
            ),
          ));
        }
      },
    );
  }
}
