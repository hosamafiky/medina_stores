part of '../domain_imports.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String address;
  final Region region;
  final City city;
  final Country country;
  final DateTime createdAt;

  const Product({
    required this.id,
    required this.name,
    required this.address,
    required this.region,
    required this.city,
    required this.country,
    required this.createdAt,
  });

  Product copyWith({
    int? userId,
    int? id,
    String? name,
    String? address,
    Region? region,
    City? city,
    Country? country,
    DateTime? createdAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      region: region ?? this.region,
      city: city ?? this.city,
      country: country ?? this.country,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, address, region, city, country, createdAt];
}

class Region extends Equatable {
  final int id;
  final String name;

  const Region({
    required this.id,
    required this.name,
  });

  Region copyWith({
    int? id,
    String? name,
  }) {
    return Region(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}

class City extends Equatable {
  final int id;
  final String name;

  const City({
    required this.id,
    required this.name,
  });

  City copyWith({
    int? id,
    String? name,
  }) {
    return City(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}

class Country extends Equatable {
  final int id;
  final String name;

  const Country({
    required this.id,
    required this.name,
  });

  Country copyWith({
    int? id,
    String? name,
  }) {
    return Country(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
