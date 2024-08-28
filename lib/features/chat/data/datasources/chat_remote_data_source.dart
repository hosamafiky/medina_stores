part of '../data_imports.dart';

abstract class ChatRemoteDataSource {
  Future<ApiResponse<PaginatedList<ChatModel>>> getChats(GetPaginatedListParams params);
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
}
