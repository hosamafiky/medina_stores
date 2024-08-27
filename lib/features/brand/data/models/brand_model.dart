part of '../data_imports.dart';

class BrandModel extends Brand {
  const BrandModel({
    required super.id,
    required super.name,
    required super.media,
    required super.createdAt,
  });

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      id: map['id'],
      name: map['name'],
      media: map['media'],
      createdAt: DateFormat(ApiConstants.dateFormat).parse(map['created_at']),
    );
  }

  factory BrandModel.fromJson(String source) => BrandModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "media": media,
      "created_at": DateFormat().format(createdAt),
    };
  }

  String toJson() => json.encode(toMap());
}
