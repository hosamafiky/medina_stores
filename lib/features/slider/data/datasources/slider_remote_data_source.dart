part of '../data_imports.dart';

abstract class SliderRemoteDataSource {
  Future<ApiResponse<PaginatedList<SliderModel>>> get getSliders;
}

class SliderRemoteDataSourceImpl implements SliderRemoteDataSource {
  @override
  Future<ApiResponse<PaginatedList<SliderModel>>> get getSliders async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: "/home/sliders",
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<PaginatedList<SliderModel>>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(
            json,
            mapper: (data) => PaginatedList<SliderModel>.fromMap(
              data,
              mapper: (json) => SliderModel.fromMap(json),
            ),
          ),
        );
  }
}
