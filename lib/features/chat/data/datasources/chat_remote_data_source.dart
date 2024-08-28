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
        data: List<ChatMessageModel>.generate(
          30,
          (index) {
            final status = MessageStatus.values[Random().nextInt(MessageStatus.values.length)];
            final messageType = ChatMessageType.values[Random().nextInt(ChatMessageType.values.length)];

            return ChatMessageModel(
              messageStatus: status,
              messageType: messageType,
              mediaUrl: messageType == ChatMessageType.audio || messageType == ChatMessageType.video || messageType == ChatMessageType.image
                  ? 'https://picsum.photos/200/300?random=${index + params.page}'
                  : null,
              text: 'Message ${index + params.page}',
              isSender: index.isEven,
            );
          },
        ),
      ),
    );
  }
}
