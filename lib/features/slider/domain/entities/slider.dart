part of '../domain_imports.dart';

class Slider extends Equatable {
  final int id;
  final String imageUrl;

  const Slider({
    required this.id,
    required this.imageUrl,
  });

  Slider copyWith({
    int? id,
    String? imageUrl,
  }) {
    return Slider(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [id, imageUrl];
}
