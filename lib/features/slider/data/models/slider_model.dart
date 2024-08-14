part of '../data_imports.dart';

class SliderModel extends Slider {
  const SliderModel({
    required super.id,
    required super.title,
    required super.description,
    required super.url,
    required super.type,
    required super.order,
    required super.media,
    required super.createdAt,
  });

  factory SliderModel.fromMap(Map<String, dynamic> map) {
    return SliderModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      url: map['url'],
      type: SliderMediaType.fromString(map['type']),
      order: map['order'],
      media: map['media'],
      createdAt: DateFormat('yyyy MMM dd hh:mm:ss').parse(map['created_at']),
    );
  }

  factory SliderModel.fromJson(String source) => SliderModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "url": url,
      "type": type.name,
      "order": order,
      "media": media,
      "created_at": DateFormat('yyyy MMM dd hh:mm:ss').format(createdAt),
    };
  }

  String toJson() => json.encode(toMap());
}
