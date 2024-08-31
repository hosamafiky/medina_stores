part of '../presentation_imports.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.getChatsUsecase,
    required this.getMessagesUsecase,
  }) : super(const ChatState());

  final GetChatsUsecase getChatsUsecase;
  final GetMessagesUsecase getMessagesUsecase;

  final PusherClientHelper _pusherClientHelper = PusherClientHelper();
  final ScrollController scrollController = ScrollController();

  void initScrollListener() {
    scrollController.addListener(() {
      final currentScroll = scrollController.position.pixels;
      final maxScroll = scrollController.position.maxScrollExtent;

      if (currentScroll == maxScroll) getChatMessages();
    });
  }

  void subscribeAndBind() async {
    _pusherClientHelper.subscribe('chat.${state.currentChat!.id}');
    await _pusherClientHelper.bind(PusherClientEvents.receivedMessage, _onMessageReceived);
    await _pusherClientHelper.bind(PusherClientEvents.sentMessage, _onMessageSent);
  }

  void _onMessageReceived(PusherEvent? event) {
    if (event != null) {
      final data = jsonDecode(event.data ?? '{}');
      final message = ChatMessageModel.fromMap(data);
      addMessage(message);
      scrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  void _onMessageSent(PusherEvent? event) {
    if (event != null) {
      final data = jsonDecode(event.data ?? '{}');
      final message = ChatMessageModel.fromMap(data);
      addMessage(message);
      scrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  void sendMessage(ChatMessage message) async {
    await _pusherClientHelper.trigger(
      PusherClientEvents.sentMessage,
      jsonEncode(ChatMessageModel.fromMessage(message).toMap()),
    );
  }

  void _unsubscribeAndDisconnect() async {
    await _pusherClientHelper.unsubscribe('chat.${state.currentChat!.id}');
    await _pusherClientHelper.disconnect();
  }

  void setCurrentChat(Chat chat) => emit(state.copyWith(currentChat: chat));

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

  Future<void> getChatMessages([int? page]) async {
    if (state.messages.data?.hasReachedEnd == true) return;
    if (state.messages.data?.currentPage == 0) emit(state.copyWith(messagesStatus: UsecaseStatus.running));
    if (page != null) emit(state.copyWith(messages: const ApiResponse.success(data: PaginatedList<ChatMessageModel>(data: []))));

    final params = GetMessagesParams(chatId: state.currentChat!.id, page: page ?? (state.messages.data!.currentPage) + 1, perPage: 5);
    final result = await getMessagesUsecase(params);
    result.fold(
      (failure) => emit(state.copyWith(
        messagesStatus: UsecaseStatus.error,
        messagesFailure: failure,
      )),
      (messages) {
        final newChats = List<ChatMessageModel>.from(messages.data!.data.map((e) => ChatMessageModel.fromMessage(e)));

        if (newChats.isEmpty) {
          final paginatedList = state.messages.data?.copyWith(
            data: state.messages.data!.data.map<ChatMessageModel>((e) => ChatMessageModel.fromMessage(e)).toList(),
            hasReachedEnd: true,
          );
          emit(state.copyWith(
            messagesStatus: UsecaseStatus.completed,
            messages: messages.copyWithSuccess(data: paginatedList),
          ));
        } else {
          final oldChats = List<ChatMessageModel>.from(state.messages.data!.data.map((e) => ChatMessageModel.fromMessage(e)));
          final paginatedList = PaginatedList<ChatMessageModel>(
            data: [...oldChats, ...newChats, ...newChats, ...newChats],
            currentPage: messages.data!.currentPage,
            lastPage: messages.data!.lastPage,
            itemsCount: messages.data!.itemsCount,
            hasReachedEnd: messages.data!.hasReachedEnd,
          );
          emit(state.copyWith(
            messagesStatus: UsecaseStatus.completed,
            messages: messages.copyWithSuccess(
              data: paginatedList,
            ),
          ));
        }
      },
    );
  }

  void addMessage(ChatMessageModel message) {
    final oldMessages = List<ChatMessageModel>.from(state.messages.data!.data.map((e) => ChatMessageModel.fromMessage(e)));
    final paginatedList = PaginatedList<ChatMessageModel>(
      data: [...oldMessages, message],
      currentPage: state.messages.data!.currentPage,
      lastPage: state.messages.data!.lastPage,
      itemsCount: state.messages.data!.itemsCount,
      hasReachedEnd: state.messages.data!.hasReachedEnd,
    );
    emit(state.copyWith(
      messages: state.messages.copyWithSuccess(data: paginatedList),
    ));
  }

  @override
  Future<void> close() {
    _unsubscribeAndDisconnect();
    return super.close();
  }
}
