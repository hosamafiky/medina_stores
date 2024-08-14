part of '../data_imports.dart';

abstract class SliderRemoteDataSource {
  Future<ApiResponse<List<SliderModel>>> get getSliders;
  Future<ApiResponse<SliderModel>> addSlider(AddSliderParams params);
}

class SliderRemoteDataSourceImpl implements SliderRemoteDataSource {
  @override
  Future<ApiResponse<List<SliderModel>>> get getSliders async {
    // final request = ApiRequest(
    //   method: RequestMethod.get,
    //   path: "/dashboard/branches",
    // );

    return Future.value(
      ApiResponse.success(
        data: List<SliderModel>.generate(
          4,
          (index) => SliderModel(
            id: index,
            imageUrl: 'https://picsum.photos/200/300?random=$index',
          ),
        ),
      ),
    );

    // return await DependencyHelper.instance.get<ApiService>().callApi<List<SliderModel>>(
    //       request,
    //       mapper: (json) => ApiResponse.fromMapSuccess(
    //         json,
    //         // mapper: (data) => List<SliderModel>.from(data['data'].map((x) => SliderModel.fromMap(x))),
    //       ),
    //     );
  }

  @override
  Future<ApiResponse<SliderModel>> addSlider(AddSliderParams params) async {
    final request = ApiRequest(
      method: RequestMethod.post,
      path: "/dashboard/branches",
      body: params.toMap(),
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<SliderModel>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(
            json,
            mapper: (data) => SliderModel.fromMap(data),
          ),
        );
  }
}
