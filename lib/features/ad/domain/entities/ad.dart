part of '../domain_imports.dart';

enum MediaType {
  image,
  video;

  static MediaType fromString(String value) {
    return MediaType.values.firstWhere((e) => e.name == value, orElse: () => MediaType.image);
  }
}

class Ad extends Equatable {
  final int id;
  final String title;
  final String description;
  final String url;
  final MediaType type;
  final int order;
  final String media;
  final DateTime createdAt;

  const Ad({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.type,
    required this.order,
    required this.media,
    required this.createdAt,
  });

  Ad copyWith({
    int? id,
    String? title,
    String? description,
    String? url,
    MediaType? type,
    int? order,
    String? media,
    DateTime? createdAt,
  }) {
    return Ad(
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
  List<Object?> get props => [id, title, description, url, type, order, media, createdAt];
}
