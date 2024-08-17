part of '../data_imports.dart';

abstract class SliderRemoteDataSource {
  Future<ApiResponse<List<SliderModel>>> get getSliders;
}

class SliderRemoteDataSourceImpl implements SliderRemoteDataSource {
  @override
  Future<ApiResponse<List<SliderModel>>> get getSliders async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: "/home/sliders",
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<List<SliderModel>>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(
            json,
            mapper: (data) => List<SliderModel>.from(data['data'].map((x) => SliderModel.fromMap(x)))
              ..insert(
                0,
                SliderModel(
                  id: data['data'].length + 1,
                  title: "Demo Slider",
                  description: "Description of the slider",
                  url: "Url",
                  type: SliderMediaType.video,
                  order: 0,
                  media: "https://videos.pexels.com/video-files/8471681/8471681-uhd_2732_1440_25fps.mp4",
                  createdAt: DateTime.now(),
                ),
              ),
          ),
        );
  }
}
