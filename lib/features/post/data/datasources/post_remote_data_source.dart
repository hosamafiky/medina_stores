part of '../data_imports.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> get getPosts;
  Future<PostModel> addPost(AddPostParams params);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  @override
  Future<List<PostModel>> get getPosts async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.POSTS,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi(
          request,
          mapper: (json) => List<PostModel>.from(json.map((x) => PostModel.fromMap(x))),
        );
  }

  @override
  Future<PostModel> addPost(AddPostParams params) async {
    final request = ApiRequest(
      method: RequestMethod.post,
      path: ApiConstants.endPoints.POSTS,
      body: params.toMap(),
    );

    return await DependencyHelper.instance.get<ApiService>().callApi(
          request,
          mapper: (json) => PostModel.fromMap(json),
        );
  }
}
