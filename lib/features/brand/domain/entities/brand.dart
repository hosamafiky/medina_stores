part of '../domain_imports.dart';

class Brand extends Equatable {
  final int id;
  final String name;
  final String media;
  final DateTime createdAt;

  const Brand({
    required this.id,
    required this.name,
    required this.media,
    required this.createdAt,
  });

  Brand copyWith({
    int? id,
    String? name,
    String? media,
    DateTime? createdAt,
  }) {
    return Brand(
      id: id ?? this.id,
      name: name ?? this.name,
      media: media ?? this.media,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static Brand get empty => Brand(id: 0, name: '', media: '', createdAt: DateTime.now());

  @override
  List<Object?> get props => [id, name, media, createdAt];
}
