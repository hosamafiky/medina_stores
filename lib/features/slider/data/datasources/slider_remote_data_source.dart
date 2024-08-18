part of '../data_imports.dart';

abstract class SliderRemoteDataSource {
  Future<ApiResponse<List<SliderModel>>> get getSliders;
}

class SliderRemoteDataSourceImpl implements SliderRemoteDataSource {
  @override
  Future<ApiResponse<List<SliderModel>>> get getSliders async {
    final request = ApiRequest(method: RequestMethod.get, path: "/home/sliders");

    return await DependencyHelper.instance.get<ApiService>().callApi<List<SliderModel>>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(
            json,
            mapper: (data) => List<SliderModel>.from(data['data'].map((x) => SliderModel.fromMap(x))),
          ),
        );
  }
}
