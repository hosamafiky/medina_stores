part of '../data_imports.dart';

abstract class AddressRemoteDataSource {
  Future<ApiResponseModel<List<AddressModel>>> getAddresses();
  Future<ApiResponseModel<AddressModel>> addAddress(AddAddressParams params);
  Future<ApiResponseModel<AddressModel>> editAddress(int id);
  Future<ApiResponseModel<AddressModel>> updateAddress(UpdateAddressParams params);
  Future<ApiResponseModel<void>> deleteAddress(int id);
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  @override
  Future<ApiResponseModel<List<AddressModel>>> getAddresses() async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.ADDRESSES,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<List<AddressModel>>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => List<AddressModel>.from(data['data'].map((x) => AddressModel.fromMap(x))),
          ),
        );
  }

  @override
  Future<ApiResponseModel<AddressModel>> addAddress(AddAddressParams params) async {
    final request = ApiRequest(
      method: RequestMethod.post,
      path: ApiConstants.endPoints.ADDRESSES,
      body: params.toMap(),
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<AddressModel>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => AddressModel.fromMap(data['data']),
          ),
        );
  }

  @override
  Future<ApiResponseModel<void>> deleteAddress(int id) async {
    final request = ApiRequest(
      method: RequestMethod.delete,
      path: '${ApiConstants.endPoints.ADDRESSES}/$id',
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<void>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(json),
        );
  }

  @override
  Future<ApiResponseModel<AddressModel>> editAddress(int id) async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: '${ApiConstants.endPoints.ADDRESSES}/$id/edit',
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<AddressModel>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => AddressModel.fromMap(data),
          ),
        );
  }

  @override
  Future<ApiResponseModel<AddressModel>> updateAddress(UpdateAddressParams params) async {
    final request = ApiRequest(
      method: RequestMethod.put,
      path: '${ApiConstants.endPoints.ADDRESSES}/${params.address.id}',
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<AddressModel>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => AddressModel.fromMap(data),
          ),
        );
  }
}
