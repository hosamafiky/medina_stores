part of '../domain_imports.dart';

class Address extends Equatable {
  final int id;
  final String title;
  final double latitude;
  final double longitude;
  final DateTime createdAt;

  const Address({
    required this.id,
    required this.title,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
  });

  Address copyWith({
    int? id,
    String? title,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
  }) {
    return Address(
      id: id ?? this.id,
      title: title ?? this.title,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, title, latitude, longitude, createdAt];
}
