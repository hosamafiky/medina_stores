part of '../data_imports.dart';

class AdModel extends Ad {
  const AdModel({
    required super.id,
    required super.title,
    required super.description,
    required super.url,
    required super.type,
    required super.order,
    required super.media,
    required super.createdAt,
  });

  factory AdModel.fromMap(Map<String, dynamic> map) {
    return AdModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      url: map['url'],
      type: MediaType.fromString(map['type']),
      order: map['order'],
      media: map['media'],
      createdAt: DateFormat(ApiConstants.dateFormat).parse(map['created_at']),
    );
  }

  factory AdModel.fromAd(Ad ad) {
    return AdModel(
      id: ad.id,
      title: ad.title,
      description: ad.description,
      url: ad.url,
      type: ad.type,
      order: ad.order,
      media: ad.media,
      createdAt: ad.createdAt,
    );
  }

  factory AdModel.fromJson(String source) => AdModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
      'type': type.name,
      'order': order,
      'media': media,
      'created_at': DateFormat(ApiConstants.dateFormat).format(createdAt),
    };
  }

  String toJson() => json.encode(toMap());
}
