part of '../domain_imports.dart';

class Address extends Equatable {
  final int id;
  final String title;
  final double latitude;
  final double longitude;
  final DateTime _createdAt;

  DateTime get createdAt => _createdAt;

  Address({
    this.id = 0,
    this.title = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
    DateTime? createdAt,
  }) : _createdAt = createdAt ?? DateTime.now();

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
      createdAt: createdAt ?? _createdAt,
    );
  }

  Map<String, dynamic> get asHeader => {'lat': latitude, 'lng': longitude};
  @override
  List<Object?> get props => [id, title, latitude, longitude, _createdAt];
}
