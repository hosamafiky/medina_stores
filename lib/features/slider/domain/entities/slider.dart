part of '../domain_imports.dart';

enum SliderMediaType {
  image,
  video;

  static SliderMediaType fromString(String type) {
    return SliderMediaType.values.firstWhere((e) => e.name == type, orElse: () => SliderMediaType.image);
  }
}

class Slider extends Equatable {
  final int id;
  final String title;
  final String description;
  final String url;
  final SliderMediaType type;
  final int order;
  final String media;
  final DateTime createdAt;

  const Slider({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.type,
    required this.order,
    required this.media,
    required this.createdAt,
  });

  Slider copyWith({
    int? id,
    String? title,
    String? description,
    String? url,
    SliderMediaType? type,
    int? order,
    String? media,
    DateTime? createdAt,
  }) {
    return Slider(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      type: type ?? this.type,
      order: order ?? this.order,
      media: media ?? this.media,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      url,
      type,
      order,
      media,
      createdAt,
    ];
  }
}
