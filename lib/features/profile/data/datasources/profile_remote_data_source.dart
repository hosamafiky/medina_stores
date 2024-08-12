part of '../data_imports.dart';

abstract class ProfileRemoteDataSource {
  Future<ApiResponse<List<ProfileModel>>> get getProfiles;
  Future<ApiResponse<ProfileModel>> addProfile(AddProfileParams params);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<ApiResponse<List<ProfileModel>>> get getProfiles async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: "/dashboard/branches",
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<List<ProfileModel>>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(
            json,
            mapper: (data) => List<ProfileModel>.from(data['data'].map((x) => ProfileModel.fromMap(x))),
          ),
        );
  }

  @override
  Future<ApiResponse<ProfileModel>> addProfile(AddProfileParams params) async {
    final request = ApiRequest(
      method: RequestMethod.post,
      path: "/dashboard/branches",
      body: params.toMap(),
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<ProfileModel>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(
            json,
            mapper: (data) => ProfileModel.fromMap(data),
          ),
        );
  }
}