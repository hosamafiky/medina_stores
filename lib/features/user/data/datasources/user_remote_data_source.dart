part of '../data_imports.dart';

abstract class UserRemoteDataSource {
  Future<ApiResponse<UserModel>> login(LoginParams params);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<ApiResponse<UserModel>> login(LoginParams params) async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: "/dashboard/branches",
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<UserModel>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(json, mapper: UserModel.fromMap),
        );
  }
}
