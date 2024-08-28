part of '../data_imports.dart';

abstract class ChatRemoteDataSource {
  Future<ApiResponse<PaginatedList<ChatModel>>> getChats(GetPaginatedListParams params);
  Future<ApiResponse<PaginatedList<ChatMessageModel>>> getChat(GetPaginatedListParams params);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  @override
  Future<ApiResponse<PaginatedList<ChatModel>>> getChats(GetPaginatedListParams params) async {
    // ignore: unused_local_variable
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.CHATS,
      queryParameters: params.toMap(),
    );

    if (params.page > 3) {
      return ApiResponse.success(
        data: PaginatedList<ChatModel>(
          currentPage: params.page,
          lastPage: 3,
          data: [],
        ),
      );
    }

    return ApiResponse.success(
      data: PaginatedList<ChatModel>(
        currentPage: params.page,
        lastPage: 3,
        data: List<ChatModel>.generate(
          30,
          (index) => ChatModel(
            id: index + params.page,
            receiverName: 'User ${index + params.page}',
            isReceiverActive: index.isOdd,
            receiverProfileImage: 'https://picsum.photos/200/300?random=${index + params.page}',
            lastMessage: 'Last message ${index + params.page}',
            lastMessageTime: DateTime.now(),
            hasUnreadMessages: index.isEven,
          ),
        ),
      ),
    );

    // return await DependencyHelper.instance.get<ApiService>().callApi<PaginatedList<ChatModel>>(
    //       request,
    //       mapper: (json) => ApiResponseModel.fromMapSuccess(
    //         json,
    //         mapper: (data) => PaginatedList<ChatModel>.fromMap(data, mapper: (x) => ChatModel.fromMap(x)),
    //       ),
    //     );
  }

  @override
  Future<ApiResponse<PaginatedList<ChatMessageModel>>> getChat(GetPaginatedListParams params) async {
    if (params.page > 3) {
      return ApiResponse.success(
        data: PaginatedList<ChatMessageModel>(
          currentPage: params.page,
          lastPage: 3,
          data: [],
        ),
      );
    }

    return ApiResponse.success(
      data: PaginatedList<ChatMessageModel>(
        currentPage: params.page,
        lastPage: 3,
        data: [
          const ChatMessageModel(
            id: 1,
            text: 'Hello',
            messageType: ChatMessageType.text,
            messageStatus: MessageStatus.notSent,
            isSender: true,
          ),
          const ChatMessageModel(
            id: 2,
            text: 'Hi',
            messageType: ChatMessageType.text,
            messageStatus: MessageStatus.notView,
            isSender: false,
          ),
          const ChatMessageModel(
            id: 3,
            text: 'How are you?',
            messageType: ChatMessageType.image,
            mediaUrl: 'https://picsum.photos/200/300?random=1',
            messageStatus: MessageStatus.viewed,
            isSender: true,
          ),
          const ChatMessageModel(
            id: 4,
            text: 'I am fine',
            messageType: ChatMessageType.text,
            messageStatus: MessageStatus.viewed,
            isSender: false,
          ),
          const ChatMessageModel(
            id: 5,
            text: 'What about you?',
            messageType: ChatMessageType.text,
            messageStatus: MessageStatus.notSent,
            isSender: true,
          ),
          const ChatMessageModel(
            id: 8,
            text: 'Check out this video!',
            messageType: ChatMessageType.video,
            mediaUrl: 'https://www.taxmann.com/emailer/images/CompaniesAct.mp4',
            messageStatus: MessageStatus.notSent,
            isSender: true,
          ),
          const ChatMessageModel(
            id: 7,
            text: 'How is your day going?',
            messageType: ChatMessageType.text,
            messageStatus: MessageStatus.viewed,
            isSender: true,
          ),
        ],
      ),
    );
  }
}
