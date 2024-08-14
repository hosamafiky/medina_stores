part of '../data_imports.dart';

class SliderModel extends Slider {
  const SliderModel({
    required super.id,
    required super.imageUrl,
  });

  factory SliderModel.fromMap(Map<String, dynamic> map) {
    return SliderModel(
      id: map['id'],
      imageUrl: map['body'],
    );
  }

  factory SliderModel.fromJson(String source) => SliderModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
    };
  }

  String toJson() => json.encode(toMap());
}
