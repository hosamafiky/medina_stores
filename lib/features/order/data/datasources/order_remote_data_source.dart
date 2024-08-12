part of '../data_imports.dart';

abstract class OrderRemoteDataSource {
  Future<ApiResponse<List<OrderModel>>> get getOrders;
  Future<ApiResponse<OrderModel>> addOrder(AddOrderParams params);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  @override
  Future<ApiResponse<List<OrderModel>>> get getOrders async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: "/dashboard/branches",
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<List<OrderModel>>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(
            json,
            mapper: (data) => List<OrderModel>.from(data['data'].map((x) => OrderModel.fromMap(x))),
          ),
        );
  }

  @override
  Future<ApiResponse<OrderModel>> addOrder(AddOrderParams params) async {
    final request = ApiRequest(
      method: RequestMethod.post,
      path: "/dashboard/branches",
      body: params.toMap(),
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<OrderModel>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(
            json,
            mapper: (data) => OrderModel.fromMap(data),
          ),
        );
  }
}