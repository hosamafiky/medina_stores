part of '../data_imports.dart';

abstract class UserRemoteDataSource {
  Future<ApiResponseModel<UserModel>> login(LoginParams params);
  Future<ApiResponseModel<UserModel>> register(RegisterParams params);
  Future<ApiResponseModel<Null>> sendOTP(SendOTPParams params);
  Future<ApiResponseModel<Null>> verifyPasswordOTP(String otp);
  Future<ApiResponseModel<UserModel>> verifyOTP(String otp);
  Future<ApiResponseModel<Null>> resetPassword(ResetPasswordParams params);
  Future<ApiResponseModel<UserProfileModel>> getUserProfile();
  Future<ApiResponseModel<Null>> logout();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<ApiResponseModel<UserModel>> login(LoginParams params) async {
    final request = ApiRequest(
      method: RequestMethod.post,
      path: ApiConstants.endPoints.login,
      body: params.toMap(),
    );
    return await DependencyHelper.instance.get<ApiService>().callApi<UserModel>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => UserModel.fromMap(data['data']),
          ),
        );
  }

  @override
  Future<ApiResponseModel<UserModel>> register(RegisterParams params) async {
    final request = ApiRequest(method: RequestMethod.post, path: ApiConstants.endPoints.register, body: params.toMap());
    return await DependencyHelper.instance.get<ApiService>().callApi<UserModel>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(json, mapper: UserModel.fromMap),
        );
  }

  @override
  Future<ApiResponseModel<Null>> logout() async {
    final request = ApiRequest(method: RequestMethod.post, path: ApiConstants.endPoints.logout);
    return await DependencyHelper.instance.get<ApiService>().callApi<Null>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(json),
        );
  }

  @override
  Future<ApiResponseModel<Null>> sendOTP(SendOTPParams params) async {
    final request = ApiRequest(method: RequestMethod.post, path: ApiConstants.endPoints.sendOTP, body: params.toMap());
    return await DependencyHelper.instance.get<ApiService>().callApi<Null>(
      request,
      mapper: (json) {
        MessageHelper.showSuccessSnackBar(
          "OTP sent successfully : ${json['data']['token']}",
          duration: const Duration(seconds: 10),
        );
        return ApiResponseModel.fromMap(json);
      },
    );
  }

  @override
  Future<ApiResponseModel<UserModel>> verifyOTP(String otp) async {
    final request = ApiRequest(method: RequestMethod.post, path: ApiConstants.endPoints.verifyOTP, body: {"token": otp});
    return await DependencyHelper.instance.get<ApiService>().callApi<UserModel>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => UserModel.fromMap(data['data']),
          ),
        );
  }

  @override
  Future<ApiResponseModel<Null>> verifyPasswordOTP(String otp) async {
    final request = ApiRequest(method: RequestMethod.post, path: ApiConstants.endPoints.verifyPasswordOTP, body: {"token": otp});
    return await DependencyHelper.instance.get<ApiService>().callApi<Null>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(json),
        );
  }

  @override
  Future<ApiResponseModel<Null>> resetPassword(ResetPasswordParams params) async {
    final request = ApiRequest(method: RequestMethod.post, path: ApiConstants.endPoints.resetPassword, body: params.toMap());
    return await DependencyHelper.instance.get<ApiService>().callApi<Null>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(json),
        );
  }

  @override
  Future<ApiResponseModel<UserProfileModel>> getUserProfile() async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.PROFILE,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<UserProfileModel>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => UserProfileModel.fromMap(data['data']),
          ),
        );
  }
}
